`timescale 1ns/1ps

module tb_top_module;

    parameter DATA_WIDTH = 32;
    parameter ADDR_WIDTH = 6;

    reg                     PCLK;
    reg                     PRESETn;
    reg                     start;
    reg                     write_en;
    reg  [ADDR_WIDTH-1:0]   addr;
    reg  [DATA_WIDTH-1:0]   wdata;

    wire [DATA_WIDTH-1:0]   rdata;

    top_module 
      dut (
        .PCLK(PCLK),
        .PRESETn(PRESETn),
        .start(start),
        .write_en(write_en),
        .addr(addr),
        .wdata(wdata),
        .rdata(rdata)
    );

    initial PCLK = 0;
    always #5 PCLK = ~PCLK;

    initial begin
        PRESETn  = 0;
        start    = 0;
        write_en = 0;
        addr     = 0;
        wdata    = 0;
        #20 PRESETn = 1;
    end

    initial begin

        #30;
        addr     = 6'd12;
        wdata    = 32'hCAFEBABE;
        write_en = 1;
        start    = 1;
        #10 start = 0;
        
      

        #20;
        
        // ---------------- READ TRANSACTION ----------------
        
        addr     = 6'd12;
        write_en = 0;
        start    = 1;
        #10;
        start = 0;
        
        
      #20;  
        
        addr     = 6'd20;
        wdata    = 32'h12345678;
        write_en = 1;
        start    = 1;
        #10 ;
        start = 0;
        
       

        #30 $finish;
    end

endmodule
