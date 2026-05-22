module apb_slave #(parameter ADDR_WIDTH = 6,parameter DATA_WIDTH = 32)
                  (PCLK,PRESETn,PSELx,PENABLE,PWRITE,PADDR,PWDATA,PREADY,PRDATA);


input                       PCLK;
input                       PRESETn;
input                       PSELx;
input                       PENABLE;
input                       PWRITE;
input [ADDR_WIDTH-1:0]      PADDR;
input [DATA_WIDTH-1:0]      PWDATA;
output reg                  PREADY;
output reg [DATA_WIDTH-1:0] PRDATA;



reg [DATA_WIDTH-1:0] mem [0:2**ADDR_WIDTH-1];


reg [1:0] present_state,next_state;

integer i;

localparam     IDLE   = 2'B00,
               SETUP  = 2'B01;
              
               
               
always@(posedge PCLK, negedge PRESETn)
    begin
        if(~PRESETn)
            begin
                present_state <= IDLE;
                next_state    <= IDLE;
            end
        else
            present_state <= next_state;
     end
     
     
     
 always@(*)
    begin
            case(present_state)
            IDLE : begin
                        if(PSELx && ~PENABLE)
                            next_state = SETUP;
                    end
                    
            SETUP : begin
                            next_state = IDLE;
                    end
            

             default : next_state = IDLE;      
            endcase
      end
    
    
                

always@(*)
    begin
        case(present_state)
        IDLE   :begin
                   PREADY  = 0;
               end
               
        SETUP  : begin
                   PREADY  = 1;
                   if(PSELx == 1 && PENABLE == 1)
                    begin
                         if (PWRITE)                                  
                             mem[PADDR] = PWDATA;
                         else if(PENABLE && ~PWRITE)
                             PRDATA = mem[PADDR];
                    end         
                    
                   else
                        PRDATA = 0; 
                end

        endcase                    
    end
    
              
endmodule
           
            
            
            
                                        
                              
                                    
                                        
                           
                       