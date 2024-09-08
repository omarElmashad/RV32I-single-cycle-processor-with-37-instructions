module store_block #(parameter data_width = 32) (
input	wire	[data_width-1 : 0]		in ,
input	wire	[1 : 0]					store_sel ,

output	reg		[data_width-1: 0]		out 

);

always @(*)
begin
	case(store_sel)
	'd0 : out = {  {24 {1'b0}} ,in[7:0 ]} ;
	'd1 : out = {  {16 {1'b0}} ,in[15:0 ]} ;
	'd2 : out = in ;
	default : out = in ;
	endcase
end


endmodule