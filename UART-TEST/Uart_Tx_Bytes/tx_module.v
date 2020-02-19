`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/06 10:47:49
// Design Name: 
// Module Name: tx_module
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


//sent 8bits datas
module tx_module
(
    sclk, 
    RSTn,
    TX_Data, 
    TX_En_Sig,
    TX_Done_Sig, 
    TX_Pin_Out
    );

    input sclk;
    input RSTn;
    input [7:0]TX_Data;
    input TX_En_Sig;
    output TX_Done_Sig;
    output TX_Pin_Out;


    /********************************/

    wire BPS_CLK;

    tx_bps_module U1
    (
        .sclk( sclk ),
        .RSTn( RSTn ),
        .Count_Sig( TX_En_Sig ),    // input - from U2
        .BPS_CLK( BPS_CLK )         // output - to U2
    );

    /*********************************/

    tx_control_module U2
    (
        .sclk( sclk ),
        .RSTn( RSTn ),
        .TX_En_Sig( TX_En_Sig ),    // input - from top
        .TX_Data( TX_Data ),        // input - from top
        .BPS_CLK( BPS_CLK ),        // input - from U2
        .TX_Done_Sig( TX_Done_Sig ),  // output - to top
        .TX_Pin_Out( TX_Pin_Out )     // output - to top
    );

    /***********************************/

endmodule

