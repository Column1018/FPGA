module FIR_TEST (
	//system signals
		sclk			, 
		s_rst_n			,
	//输入输出
		fir_in			,
		fir_out

);
    parameter			IN_DATAWIDTH		=	16		;	//输入数据位宽
    parameter			OUT_WIDTH			=	33		;	//输出位宽
    parameter			COEFF_WIDTH			=	16		;	//系数位宽
    parameter			ORDER				=	8		;	//阶数

    parameter			COF0				=	16'd627	;	//627,    539,    683,    782,    818,    782,    683,    539,    627
    parameter			COF1				=	16'd539	;
    parameter			COF2				=	16'd683	;
    parameter			COF3				=	16'd782	;
    parameter			COF4				=	16'd818	;
    parameter			COF5				=	16'd782	;
    parameter			COF6				=	16'd683	;
    parameter			COF7				=	16'd539	;
    parameter			COF8				=	16'd627	;

	integer 	i	;


    input								sclk			;
    input								s_rst_n			;
    input			[IN_DATAWIDTH-1:0]	fir_in			;
    output			[OUT_WIDTH-1:0]		fir_out			;

    reg				[IN_DATAWIDTH-1:0]	shift_reg	[0:ORDER]	;
    wire			[OUT_WIDTH-1:0]		fir_out_reg			;

    always @ (posedge sclk or negedge s_rst_n) begin
    	if(s_rst_n == 1'b0)begin
    		
    		for (i = 0; i <= ORDER; i = i + 1)
    		    begin
    		       shift_reg [i] <= 0; 
    		    end
    	end
    	else begin	
            shift_reg [0] <= fir_in;
            
            for (i = 0; i <= ORDER ; i = i + 1)
                begin
                    shift_reg [i+1] <= shift_reg[i];
                end
        end
    end

    assign fir_out_reg = COF0*shift_reg[0]+COF1*shift_reg[1]+COF2*shift_reg[2]
    					+COF3*shift_reg[3]+COF4*shift_reg[4]
    					+COF5*shift_reg[5]
    					+COF6*shift_reg[6]+COF7*shift_reg[7]
    					+COF8*shift_reg[8];

    assign fir_out = fir_out_reg<<4;
endmodule