`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/06 12:00:34
// Design Name: 
// Module Name: sim
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


module sim(  );

    reg sclk;
    reg RSTn;
    reg Do_sig;
    wire TX_Pin_Out;


    initial begin
        sclk = 1;
        RSTn <= 0;
        #100
        RSTn <= 1;
        #100
        Do_sig <= 1;
        #20
        Do_sig <= 0;

    end

    always #10 sclk = ~sclk;

    uartsent uartsent_inst
(
    .sclk(sclk),                //PLL CLK 200M(use low clk is OK,but need change bps)
    .RSTn(RSTn),               //SYS Reset             (active Low)
    .Do_sig(Do_sig),             //Start send signal     (active High)
    //Input two signal's time delay count register
    .TX_Pin_Out(TX_Pin_Out)          //Uart TX pin,connect to MCU
);
endmodule
