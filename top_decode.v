module top_decode (
input	wire	[31:0]	inst ,
input	wire			zero_flag , SLT_flag , SLTu_flag ,

output	wire	 		reg_write , mem_write , pc_src,
output	wire			alu_src_B , alu_src_A ,
output	wire	[2:0]	ImmSrc , 
output	wire	[3:0]	alu_control,
output	wire	[1:0]	result_src, 
output	wire	[2:0]	size_data_sel	
);

//internal signal between main and branch decoder
wire	branch, jump ;

//internal signal between main and ld_st decoder
wire	LD_ST_op;

//internal signal between main and alu decoder
wire	[1:0]	alu_op;

main_decoder main_decode (
.op_code 		(inst[6:0]),
.reg_write		(reg_write) , 
.alu_src_B		(alu_src_B) , 
.alu_src_A		(alu_src_A) , 
.mem_write		(mem_write)  ,
.branch			(branch) , 
.jump			(jump) , 
.LD_ST_op		(LD_ST_op),
.imm_src 		(ImmSrc), 
.alu_op 		(alu_op), 
.result_src		(result_src) 
);

alu_decoder alu_decode (
.op_code 		(inst[6:0]),
.func3			(inst[14:12]),
.alu_op			(alu_op),
.func7_bit5		(inst[30]),
.alu_control	(alu_control)
);

ld_st_decode load_store_decode (
.func3			(inst[14:12]),
.ld_st_operation(LD_ST_op),
.size_data_sel	(size_data_sel)
);

branch_decoder branch_decode (
.func3				(inst[14:12]),
.branch_operation	(branch) , 
.jump_operation		(jump) , 
.zero_flag			(zero_flag) , 
.SLT_flag			(SLT_flag) , 
.SLTu_flag			(SLTu_flag) ,
.is_true			(pc_src)
);

endmodule