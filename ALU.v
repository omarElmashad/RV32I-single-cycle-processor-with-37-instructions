module ALU #(parameter data_width = 32 , parameter alu_func_width = 4 ) (
input	wire		[data_width-1 		: 0]	A,B,
input	wire		[alu_func_width-1 	: 0]	alu_func ,

output	reg			[data_width	-1		: 0]	alu_result,
output	wire								  	zero_flag , SLT_flag , SLTu_flag 
);

localparam 	add = 'd0,
			sub = 'd1,
			AND = 'd2,
			OR  = 'd3,
			LSL = 'd4, //logic shift left
			LSR = 'd5, //logic shift right
			ASR	= 'd6, //arithmatic shift right
			XOR = 'd7,
			SLT	= 'd8, //set less than
			SLTu ='d9 //set less than unsigned
;

assign	zero_flag = ~(|alu_result) ;
assign	SLT_flag  = alu_result[0]  ;
assign	SLTu_flag = alu_result[0]  ;
always @(*)
begin
	case(alu_func)
	add : alu_result = $signed(A) + $signed(B) ;
	sub : alu_result = $signed(A) - $signed(B) ;
	AND	: alu_result = A & B ;
	OR	: alu_result = A | B ;
	LSL	: alu_result = A >> B[4:0] ;
	LSR	: alu_result = A << B[4:0] ;
	ASR	: alu_result = A >>>B[4:0] ;
	XOR : alu_result = A ^ B ;
	SLT : alu_result = ($signed (A) < $signed (B) ) ? 1 : 0 ;
	SLTu: alu_result = ( A < B ) 					? 1 : 0 ;
	
	default: alu_result = 'd0 ;
	
	endcase
end

endmodule