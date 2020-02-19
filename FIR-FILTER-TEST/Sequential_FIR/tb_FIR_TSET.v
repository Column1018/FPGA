`timescale 1ns/1ns

module tb_FEST_TEST ();
    reg				sclk;
    reg				s_rst_n;
    reg		[15:0]	fir_in;
    wire 	[32:0]	fir_out;
    integer  j;
    initial begin
    	sclk = 1;
    	s_rst_n = 0;
    	#100
    	s_rst_n = 1;
        #2000
        $stop;
    end

    always #10 sclk = ~sclk;

    reg[15:0] memory[0:1023];
    initial
        begin
            $readmemb("E:/FutureStudy/Verilog_study/Codes/small_demo/FIR/data.txt", memory, 0, 1023);
            // for (n = 0; n < 1024; n = n + 1) 
            //     begin
            //         $display("%b",memory[n]);
            //     end
        end

    always #0
    begin
        for (j = 0; j < 1024; j = j+1) begin
            #10;
            fir_in = memory[j];
        end
    end

    	FIR_TEST inst_FIR_TEST (
			.sclk    (sclk),
			.s_rst_n (s_rst_n),
			.fir_in  (fir_in),
			.fir_out (fir_out)
		);

endmodule