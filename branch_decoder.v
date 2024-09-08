module	branch_decoder (
input	wire	[2:0]	func3,
input	wire			branch_operation , jump_operation , zero_flag , SLT_flag , SLTu_flag ,

output	reg				is_true
);

always @ (*)
begin
	if(branch_operation)
	begin
		case(func3)
			3'b000 : is_true = zero_flag ;
			3'b001 : is_true = !zero_flag;
			3'b100 : is_true = SLT_flag ;	
			3'b101 : is_true = !(zero_flag | SLT_flag) ;
			3'b110 : is_true = SLTu_flag ;
			3'b111 : is_true = !(zero_flag | SLTu_flag) ;
			default : is_true = 1'b0 ;
		endcase
	end
	
	else if(jump_operation)
	begin
		is_true = 1'b1 ;
	end
	
	else 
	begin
		is_true = 1'b0 ;
	end

end


endmodule