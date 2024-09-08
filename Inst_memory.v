module ROM #( parameter instruction_width = 32) (
input	wire	[instruction_width -1 : 0] 	addres ,	

output	wire	[instruction_width -1 : 0]	inst			

);

reg		[instruction_width-1 : 0] Rom [0 : 1024 ] ;

initial
begin
$readmemh("riscv_test.txt", Rom);
end

assign inst = Rom[addres >> 2] ; //divied by 4 

endmodule
