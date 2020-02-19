`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/11/06 10:48:43
// Design Name: 
// Module Name: uartsent
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


//------------------------------------------------------------
//-- Filename ﹕ uartsent
//-- Author ﹕tony-ning
//-- Description ﹕串口发送模块
//-- Called by ﹕top
//-- Revision History ﹕16- -
//-- Revision 1.0
//-- wechat  ﹕ v_jiaocheng
//-- Copyright(c) v_jiaocheng  All right reserved
//------------------------------------------------------------
module uartsent
(
    input                       sclk,                //PLL CLK 200M(use low clk is OK,but need change bps)
    input                       RSTn,               //SYS Reset             (active Low)
    input                       Do_sig,             //Start send signal     (active High)
    input   [31:0]              fxCnt,              //Input signal count register
    input   [31:0]              fBaseCnt,           //Stand signal count register           
    input   [31:0]              DutyCnt,            //Input signal's duty count register
    input   [31:0]              DelayCnt,           //Input two signal's time delay count register
    output                      TX_Pin_Out          //Uart TX pin,connect to MCU
);


    wire                        isDone;             //tx_module send 8bits done signal
    reg                         rEN     =   1'b0;   //Sent trigger 
    reg     [7:0]               Data      [15:0];   //Sent data buffer
    reg     [5:0]               i       =   6'd0;   //Send state
    reg     [7:0]               data;               //Data give to tx_module to send

    
    //Uart tx_module instantiation
    tx_module   U0_tx           (
                .sclk           (sclk       ), 
                .RSTn           (RSTn       ),
                .TX_Data        (data       ), 
                .TX_En_Sig      (rEN        ),
                .TX_Done_Sig    (isDone     ), 
                .TX_Pin_Out     (TX_Pin_Out )
                );
    
    
    //Call tx_module to send mesured data
    always@(posedge sclk or posedge Do_sig)          
        if(Do_sig) begin
            Data[15]    <=  DutyCnt     [31:24];    //transfor data to temp
            Data[14]    <=  DutyCnt     [23:16];    //[15:12]duty data
            Data[13]    <=  DutyCnt     [15:8 ]; 
            Data[12]    <=  DutyCnt     [7 :0 ];  
            Data[11]    <=  DelayCnt    [31:24];    //[11: 8]delay data
            Data[10]    <=  DelayCnt    [23:16];   
            Data[9]     <=  DelayCnt    [15:8 ];    
            Data[8]     <=  DelayCnt    [7 :0 ]; 
                    
            Data[7]     <=  fxCnt       [31:24];    //[7:4]fx count data
            Data[6]     <=  fxCnt       [23:16];
            Data[5]     <=  fxCnt       [15:8 ]; 
            Data[4]     <=  fxCnt       [7 :0 ];  
            Data[3]     <=  fBaseCnt    [31:24];    //[7:4]f_stand count data
            Data[2]     <=  fBaseCnt    [23:16];   
            Data[1]     <=  fBaseCnt    [15:8 ];    
            Data[0]     <=  fBaseCnt    [7 :0 ]; 

            // Data[15]    <=  8'h12;    //transfor data to temp
            // Data[14]    <=  8'h23;    //[15:12]duty data
            // Data[13]    <=  8'h34; 
            // Data[12]    <=  8'h45;  
            // Data[11]    <=  8'h56;    //[11: 8]delay data
            // Data[10]    <=  8'h67;   
            // Data[9]     <=  8'h78;    
            // Data[8]     <=  8'h89; 
                    
            // Data[7]     <=  8'hab;    //[7:4]fx count data
            // Data[6]     <=  8'hac;
            // Data[5]     <=  8'hcb; 
            // Data[4]     <=  8'hbc;  
            // Data[3]     <=  8'hcd;    //[7:4]f_stand count data
            // Data[2]     <=  8'hdc;   
            // Data[1]     <=  8'had;    
            // Data[0]     <=  8'hef; 

            i           <=                 1'b1;    //state change to send state        
        end else begin
            if(rEN == 1'b0 && i>= 1'b1) begin       //tx_module start signal & state is send state
                case(i)                             
                6'd 1  : begin  data <= Data[15];  rEN <= 1'b1;  i <= i +1'b1; end
                6'd 2  : begin  data <= Data[14];  rEN <= 1'b1;  i <= i +1'b1; end
                6'd 3  : begin  data <= Data[13];  rEN <= 1'b1;  i <= i +1'b1; end
                6'd 4  : begin  data <= Data[12];  rEN <= 1'b1;  i <= i +1'b1; end
                6'd 5  : begin  data <= Data[11];  rEN <= 1'b1;  i <= i +1'b1; end
                6'd 6  : begin  data <= Data[10];  rEN <= 1'b1;  i <= i +1'b1; end
                6'd 7  : begin  data <= Data[9 ];  rEN <= 1'b1;  i <= i +1'b1; end
                6'd 8  : begin  data <= Data[8 ];  rEN <= 1'b1;  i <= i +1'b1; end
                                                   
                6'd 9  : begin  data <= Data[7 ];  rEN <= 1'b1;  i <= i +1'b1; end
                6'd10  : begin  data <= Data[6 ];  rEN <= 1'b1;  i <= i +1'b1; end
                6'd11  : begin  data <= Data[5 ];  rEN <= 1'b1;  i <= i +1'b1; end
                6'd12  : begin  data <= Data[4 ];  rEN <= 1'b1;  i <= i +1'b1; end
                6'd13  : begin  data <= Data[3 ];  rEN <= 1'b1;  i <= i +1'b1; end
                6'd14  : begin  data <= Data[2 ];  rEN <= 1'b1;  i <= i +1'b1; end
                6'd15  : begin  data <= Data[1 ];  rEN <= 1'b1;  i <= i +1'b1; end
                6'd16  : begin  data <= Data[0 ];  rEN <= 1'b1;  i <= i +1'b1; end
                //sent mode verify code,equal test freq,MCU needed
                6'd17  : begin  data <= 8'h0d   ;  rEN <= 1'b1;  i <= i +1'b1; end
                6'd18  : begin  data <= 8'h0a   ;  rEN <= 1'b1;  i <= i +1'b1; end
                6'd19  :                                         i <= 1'b0;

                // 6'd17  : begin  data <= 8'hff   ;  rEN <= 1'b1;  i <= i +1'b1; end
                //sent mode verify code,equal test freq,MCU needed
                // 6'd18  : begin  data <= 8'h0d   ;  rEN <= 1'b1;  i <= i +1'b1; end
                // 6'd19  : begin  data <= 8'h0a   ;  rEN <= 1'b1;  i <= i +1'b1; end
                // 6'd20  :                                         i <= 1'b0;
                endcase
            end
            if(isDone == 1'b1)  begin               //promise tx_module start signal only a clk pulse
                rEN <=1'b0;
            end 
        end
                                            
                        
                        
endmodule
    
