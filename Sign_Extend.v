module sign_extend (
input	wire	[31 : 7] Immed_in ,
input	wire	[2 : 0 ] ImmSrc ,

output	reg		[31 : 0] imm_extend 

);

localparam	I_type = 'b000,
			S_type = 'b001,
			B_type = 'b010,
			j_type = 'b011,
			U_type = 'b100  //upper immediate
; 

always @(*)
begin
	case(ImmSrc)
	I_type : imm_extend = {   { 20{ Immed_in[31] }} , Immed_in[31:20] } ;
	S_type : imm_extend = {   { 20{ Immed_in[31] }} , Immed_in[31:25] , Immed_in[11:7] } ;
	B_type : imm_extend = {   { 20{ Immed_in[31] }} , Immed_in[7], Immed_in[30:25] , Immed_in[11:8] , 1'b0 } ;
	j_type : imm_extend = {   { 12{ Immed_in[31] }} , Immed_in[19:12], Immed_in[20] , Immed_in[30:21] , 1'b0 } ;
	U_type : imm_extend = {   Immed_in[31:12]    ,   {12{1'b0}} } ;
	default: imm_extend = 'bX ;
	
	endcase

end


endmodule