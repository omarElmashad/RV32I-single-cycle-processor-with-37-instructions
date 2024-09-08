module mux4_1 #(parameter data_width = 32) (
input	wire	[data_width-1 : 0]	in0 , in1 , in2 , in3 ,
input	wire	[1:0]				selection ,
output	reg		[data_width-1 : 0]	mux_out

);

always @(*)
begin
	case(selection)
		'b00  : mux_out = in0;
		'b01  : mux_out = in1;
		'b10  : mux_out = in2;
		'b11  : mux_out = in3 ;	
	endcase

end

endmodule