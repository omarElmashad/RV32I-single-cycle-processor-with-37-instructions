module PC (
input	wire	[31:0]	in ,
input	wire			rst,clk,

output	reg		[31:0]		out
);

always @(posedge clk or negedge rst)
begin
	if(!rst)
	out <= 'd0;
	else
	out <= in ;
end

endmodule