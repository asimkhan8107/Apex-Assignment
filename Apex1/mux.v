`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 19.08.2023 19:40:02
// Design Name: 
// Module Name: mux
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


module mux(
    input clk,
    input symbol_clk,
    input [2:0] switch_clk_cycles,
    input [7:0] DS1,
    input [7:0] DS2,
    input [7:0] DS3,
    input [2:1] mode,
    output reg [7:0] multiplexed_data
    );    
    
    /* For mode-3, i have divided a clk for purpose of making an counter and at a counter,
    and at counter, sample the data*/   
    reg clk_2 = 0;
    reg [3:0] counter = 0;
    
    always@(posedge clk)
    begin : clock_divide
        clk_2 <= clk_2 + 1;
    end : clock_divide
    
    always@(posedge clk_2)
    begin : count
        counter <= counter + 1;
    end : count   

    always @(posedge clk )
    begin : main_block
    if(symbol_clk == 1'd1 && mode == 2'd1 && switch_clk_cycles == 3'd6)
    begin : mode_1 
            multiplexed_data <= DS1; 
    end : mode_1
            
    else if(mode == 2'd2 && switch_clk_cycles == 3'd3)
    begin : mode_2
        if(symbol_clk)
            multiplexed_data <= DS1;
        else 
            multiplexed_data <= DS2;          
    end : mode_2
    
    else if(mode == 2'd3 && switch_clk_cycles == 3'd2)
    begin : mode_3
        case(counter)
            4'd1 : multiplexed_data <= DS1;
            4'd2 : multiplexed_data <= DS2;
            4'd3 : multiplexed_data <= DS3;
            4'd4 : multiplexed_data <= DS1;
            4'd5 : multiplexed_data <= DS2;
            4'd6 : multiplexed_data <= DS3;
            4'd7 : multiplexed_data <= DS1;
            4'd8 : multiplexed_data <= DS2;
           // 4'd9 : multiplexed_data <= DS3;
            default: multiplexed_data <= DS3;
        endcase    
    end : mode_3
    end : main_block                    
endmodule 

/* I have hardcoded this design, and in mode-3 there is a tiny mistake on sampling of data
otherwise for mode- 1 and mode-2 sucessfully sampled the data */

// i have tried my best!!!!!!!!

//                     ?????????Thankyou????????? 


