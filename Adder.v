module	adder #(parameter data_width = 32 ) (
input	wire	[data_width-1 : 0]	op1,op2,

output	wire	[data_width-1 : 0]	out 

);

assign	out = op1 + op2 ;

endmodule