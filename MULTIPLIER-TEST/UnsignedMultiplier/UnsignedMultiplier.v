module multiplier (
	//system signals
		sclk			, 
		s_rst_n			,
	//input signals
		x				,
		y				,
	//output signals
		p

);
    input					sclk			;
    input					s_rst_n			;
    input			[ 7:0]	x				;
    input			[ 7:0]	y				;
    output	reg		[15:0]	p				;

    reg				[ 1:0]	current_state 	;
    reg				[ 1:0]	next_state		;		//状态机状态寄存器
//	 reg				[ 1:0]	state		;
    reg				[ 2:0]	count			;		//移位计数器
    reg				[15:0]	x_reg			;		//数据寄存器
    reg				[ 7:0]	y_reg			;
    reg 			[15:0]	p1				;		//输出寄存器

    parameter			S0			=	0		;
    parameter			S1			=	1		;
    parameter			S2			=	2		;	//状态参数

    always @ (posedge sclk or negedge s_rst_n) begin	//三段式状态机第一段
    	if(s_rst_n == 1'b0)begin
    		current_state <= S0;
			end
    	else	
         current_state <= next_state;
    end

    always @ (*) begin									//三段式状态机第二段
    	case(current_state)
    		S0:	
    			next_state = S1;
    		S1:begin
    			if (count < 7) begin					//当判断y第七个数据时
    			    next_state = S1;					//提前把下一个状态给状态寄存器
    			end
    			else
    				next_state = S2;					//当判断完所有位，正好进入下一状态
    		end
    		S2:	
    			next_state = S0;
    		default:;
    	endcase
    end

    always @ (posedge sclk or negedge s_rst_n) begin
    	if(s_rst_n == 1'b0)begin
			p <= 0;
			p1 <= 0;
    		x_reg <= 0;
    		y_reg <= 0;
			count = 0;
		end
    	else begin
    		case (current_state) 
    		    S0:begin
    		    		x_reg <= {{8{x[7]}},x};			//x需要左移，所以需要补8个高位
    		    		y_reg <= y;
    		    end
    		    S1:begin
    		            if (y_reg[0]==1) begin
    		                p1 <= p1 + x_reg;			//按照公式
    		            end								
    		            y_reg <= y_reg >> 1;
    		            x_reg <= x_reg << 1;
						count = count + 1'b1;
    		    end
    		    S2:begin
    		    		p <= p1;
						p1 <= 0;
    		    end
    		    default:;
    		endcase
    	end       
    end
endmodule