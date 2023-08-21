`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2023 19:47:05
// Design Name: 
// Module Name: mux_test
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mux_test();
    reg clk;
    reg symbol_clk;
    reg [2:0] switch_clk_cycles;
    reg [7:0] DS1;
    reg [7:0] DS2;
    reg [7:0] DS3;
    reg [2:1] mode;
    wire [7:0] multiplexed_data;
    
   // reg [7:0] m;
    
    mux DUT(.clk(clk), .symbol_clk(symbol_clk), .switch_clk_cycles(switch_clk_cycles), 
            .DS1(DS1), .DS2(DS2), .DS3(DS3), .mode(mode), .multiplexed_data(multiplexed_data));
            
    always #10 clk = ~clk;
    always #60 symbol_clk = ~symbol_clk;
    
    initial
    begin
        clk = 1;
        symbol_clk = 1;
        
        // mode - 1 
        DS1 = 8'HA0;
        DS2 = 8'HB0;
        DS3 = 8'HC0;
        
        // Uncomment, below any one mode to change mode
        mode = 2'd1;            // mode - 1
        switch_clk_cycles = 3'd6;
        
        /*
        mode = 2'd2;            // mode - 2
        switch_clk_cycles = 3'd3;
        */
        /*
        mode = 2'd3;            // mode - 3 
        switch_clk_cycles = 3'd2;
        */
        #120 
        DS1 = 8'HA1;
        DS2 = 8'HB1;
        DS3 = 8'HC1;
        #120
        DS1 = 8'HA2;
        DS2 = 8'HB2;
        DS3 = 8'HC2;
        
        #120
        $finish;
    end
endmodule
