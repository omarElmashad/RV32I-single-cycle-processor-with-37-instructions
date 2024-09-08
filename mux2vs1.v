module mux2_1 #(parameter data_width = 32) (
input	wire	[data_width-1 : 0]	in0 , in1 ,
input	wire						selection ,
output	wire	[data_width-1 : 0]	mux_out

);

assign mux_out = (selection ? in1 : in0 ) ;

endmodule