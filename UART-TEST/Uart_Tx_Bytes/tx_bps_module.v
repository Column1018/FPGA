`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/06 10:45:38
// Design Name: 
// Module Name: tx_bps_module
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


//Found from the internet, verify OK
module tx_bps_module
(
    sclk, RSTn,
     Count_Sig, 
     BPS_CLK
);

    input sclk;
     input RSTn;
     input Count_Sig;
     output BPS_CLK;
     
     /*************Count_BPS = sclk / wish bps**************/
     
     reg [12:0]Count_BPS;
     
     always @ ( posedge sclk or negedge RSTn )
        if( !RSTn )
             Count_BPS <= 13'd0;
         else if( Count_BPS == 13'd5207 )
             Count_BPS <= 13'd0;
         else if( Count_Sig )
             Count_BPS <= Count_BPS + 1'b1;
         else
             Count_BPS <= 13'd0;
              
     /********************************/

    assign BPS_CLK = ( Count_BPS == 13'd2603 ) ? 1'b1 : 1'b0;

    /*********************************/

endmodule
