`timescale 1ns/1ns
module tb_multiply();

reg 					sclk;
reg 					mult_begin;
reg 			[31:0]	mult_op1				;
reg 			[31:0]	mult_op2				;
wire			[63:0]	product					;
wire					mult_end				;
initial begin
	sclk = 1;
	mult_begin = 0;
	#100
	mult_begin = 1;
	#1000
	$stop;
end

always #10 sclk = ~sclk;

always @ (posedge sclk) begin
	if(mult_begin == 1'b0)
		mult_op1 <= 0;
		mult_op2 <= 0;
	else	
        mult_op1 <= mult_op1 + 1;
        mult_op2 <= mult_op2 + 1;
end

	multiply inst_multiply
		(
			.clk        (sclk),
			.mult_begin (mult_begin),
			.mult_op1   (mult_op1),
			.mult_op2   (mult_op2),
			.product    (product),
			.mult_end   (mult_end)
		);


endmodule
