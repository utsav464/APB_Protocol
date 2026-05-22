
module top_module  #(parameter DATA_WIDTH= 32,
                              ADDR_WIDTH = 6)
                   (PCLK,PRESETn,start,write_en,addr,wdata,rdata);
                   
                   
input                   PCLK;
input                   PRESETn;
input                   start;
input                   write_en;
input  [DATA_WIDTH-1:0] wdata;
input  [ADDR_WIDTH-1:0] addr;
output [DATA_WIDTH-1:0] rdata;



wire                  PREADY;
wire                  PWRITE;
wire                  PENABLE;
wire                  PSELx;
wire [DATA_WIDTH-1:0] PWDATA;
wire [DATA_WIDTH-1:0] PRDATA;
wire [ADDR_WIDTH-1:0] PADDR;



apb_master DUT1(
             
                   .PCLK(PCLK),
                   .PRESETn(PRESETn),
                   .start(start),
                   .PREADY(PREADY),
                   .write_en(write_en),
                   .PRDATA(PRDATA),
                   .addr(addr),
                   .wdata(wdata),
                   .PSELx(PSELx),
                   .PENABLE(PENABLE),
                   .PWRITE(PWRITE),
                   .PWDATA(PWDATA),
                   .PADDR(PADDR),
                   .rdata(rdata)
               );


apb_slave DUT (
                 .PCLK(PCLK),
                 .PRESETn(PRESETn),
                 .PSELx(PSELx),
                 .PENABLE(PENABLE),
                 .PWRITE(PWRITE),
                 .PADDR(PADDR),
                 .PWDATA(PWDATA),
                 .PREADY(PREADY),
                 .PRDATA(PRDATA)
                 
                 );               



endmodule
