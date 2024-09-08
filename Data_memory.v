module Ram #(parameter data_width = 32 , parameter address_bits = 32   ) (
input	wire	[address_bits-1 : 0]	address ,
input	wire	[data_width-1 : 0]		WD ,
input	wire							WE , clk ,

output	wire	[data_width-1 : 0]		RD 

);

reg	[data_width-1 : 0]	Ram	[0 : 1024 ] ;
integer i;

always @(posedge clk  )
begin
	if(WE)
		Ram[address] <= WD ; 
end

assign RD = Ram[address ] ;

endmodule