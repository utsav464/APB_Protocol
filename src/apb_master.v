
module apb_master #(parameter DATA_WIDTH= 32,
                              ADDR_WIDTH = 6)
                              
 (                             
input                   PCLK,
input                   PRESETn,
input                   start,
input                   PREADY,
input                   write_en,
input  [DATA_WIDTH-1:0] PRDATA,wdata,
input  [ADDR_WIDTH-1:0] addr,

output reg PSELx,
output reg PENABLE,
output reg PWRITE,
output reg [DATA_WIDTH-1:0] PWDATA,
output reg [ADDR_WIDTH-1:0] PADDR,
output reg [DATA_WIDTH-1:0] rdata
);


reg [1:0] present_state,next_state;


localparam     IDLE   = 2'B00,
               SETUP  = 2'B01,
               ACCESS = 2'B10;
               
               
         

               
               
always@(posedge PCLK, negedge PRESETn)
    begin
        if(~PRESETn)
            present_state <= IDLE;
        else
            present_state <= next_state;
     end
     
     
     
 always@(*)
    begin
            case(present_state)
            
            IDLE : begin
                       if(start)
                          next_state = SETUP;
                       else   
                          next_state = IDLE;
                    end
                    
            SETUP : begin
                            next_state = ACCESS;
                    end
            
            ACCESS: begin
                        if(PREADY && start)   
                            next_state = SETUP;
                        else if (PREADY && ~start)
                            next_state = IDLE;
                        else 
                            next_state = ACCESS;
                   end
            default : next_state = IDLE;       
            endcase
      end
      
      


always@(*)
    begin
         case(present_state)
            IDLE    :   begin
                            PSELx   = 1'b0;
                            PENABLE = 1'b0;
                            PWRITE  = 1'b0;
                            PWDATA  = {DATA_WIDTH{1'b0}};
                            PADDR   = {ADDR_WIDTH{1'b0}};
                        end    
              
            SETUP   :  begin
                            PSELx   = 1;
                            PENABLE = 0;
                            PWRITE  = write_en;
                            PADDR   = addr;
                            if(write_en)
                                PWDATA = wdata;
                            else 
                                PWDATA = {DATA_WIDTH{1'BZ}};    
                        end          
           
           ACCESS   :  begin
                            PSELx   = 1;
                            PENABLE = 1;
                            PWRITE  = write_en;
                            PADDR   = addr;
                            if (~write_en && PREADY)
                                begin
                                    rdata <= PRDATA;
                                    PWDATA <= {DATA_WIDTH{1'bz}};
                                end     
                            
                        end 
           endcase
       end    
            
      
endmodule
