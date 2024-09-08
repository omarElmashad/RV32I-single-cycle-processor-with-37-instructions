module reg_file #(parameter data_width = 32 ) (
input	wire	[data_width-1 : 0]		WD3 ,
input	wire	[4 : 0 ]				A1,A2,A3,
input	wire							WE3 ,
input 	wire							clk,

output	wire 	[data_width-1: 0]		RD1,RD2			
);

reg		[data_width-1 : 0] 	reg_file [0 : 31] ;

always @(posedge clk )
begin

	reg_file[0] <= 'd0;

end

always @(posedge clk  )
begin
	
	
	if (WE3)
	begin
	reg_file[A3] <= WD3 ;
	end

end

assign	RD1 = reg_file[A1];
assign	RD2 = reg_file[A2];

endmodule