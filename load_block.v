module load_memory #(parameter data_width = 32) (
input	wire	[data_width-1 : 0]		in_data ,
input	wire	[2 : 0]					selection,

output reg		[data_width-1 : 0]		load_data

);

always @(*)
begin
	case(selection)
	'd0 : load_data = { {24{in_data[7]} } , in_data[7:0]} ; //load byte
	'd1 : load_data = {  {16{in_data[7]}} , in_data[15:0]} ;//load half word
	'd2 : load_data = in_data ;							 //load word
	'd3 : load_data = { {24{1'b0}} , in_data[7:0]} ;		 //load byte unsigned	
	'd4 : load_data = { {16{1'b0}} , in_data[15:0]} ;		 //load half word unsigned
	default :load_data = in_data ;
	endcase
end

endmodule