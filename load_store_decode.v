module ld_st_decode (
input	wire	[2:0]	func3,
input	wire			ld_st_operation,

output	reg	[2:0]	size_data_sel
);

always @(*)
begin
	if(ld_st_operation)
	begin
		case(func3)
			3'd0 : size_data_sel = 'd0 ; //lb or sb
			3'd1 : size_data_sel = 'd1 ; //lh or sh
			3'd2 : size_data_sel = 'd2 ; //lw or sw
			3'd4 : size_data_sel = 'd3 ; //lbu
			3'd5 : size_data_sel = 'd4 ; //lhu
			default : size_data_sel = 'd2;
		endcase
	end
	
	else
	begin
		size_data_sel = 'd2;
	end

end


endmodule