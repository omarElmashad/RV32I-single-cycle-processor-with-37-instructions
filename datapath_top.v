module data_path (
input	wire	[31:0]		inst , read_data ,
input	wire				reg_write , pc_src , alu_src_B , alu_src_A ,
input	wire	[1:0]		result_src ,
input	wire	[2:0]		ImmSrc , size_data_sel ,
input	wire	[3:0]		alu_control,
input  	wire				clk,rst,

output	wire	[31:0]		pc_addres , alu_result , write_data ,
output	wire				zero_flag , SLT_flag , SLTu_flag

);

parameter data_width=32 ;
parameter alu_func_width=4;

wire	[data_width-1 : 0]	A , B  ,FB_reg ,RD1,RD2,pc , pc_target;
wire	[data_width-1 : 0]	imm_extend , pc_next , pc_plus4 , load_logic_out ;

ALU #( .data_width(data_width) , .alu_func_width (alu_func_width) ) ALU (
.A			(A),
.B			(B),
.alu_func	(alu_control),
.alu_result	(alu_result),
.zero_flag	(zero_flag) , 
.SLT_flag	(SLT_flag) ,
.SLTu_flag	(SLTu_flag)
);

reg_file #(.data_width(data_width) )	reg_file (
.WD3		(FB_reg),
.A1			(inst[19:15]),
.A2			(inst[24:20]),
.A3			(inst[11:7]),
.WE3		(reg_write),
.clk		(clk),
.RD1		(RD1),
.RD2		(RD2)	
);

mux2_1 #( .data_width(data_width) ) operand_A_mux (
.in0(RD1) , 
.in1(pc_addres) ,
.selection(alu_src_A),
.mux_out(A)
);

mux2_1 #( .data_width(data_width) ) operand_B_mux (
.in0(RD2) , 
.in1(imm_extend) ,
.selection(alu_src_B),
.mux_out(B)
);

PC P_count (
.in (pc_next),
.rst(rst),
.clk(clk),
.out(pc_addres)
);

adder #(.data_width(data_width)) pc_adder4 (
.op1(pc_addres),
.op2('d4),
.out(pc_plus4)
);

mux2_1 #( .data_width(data_width) ) jump_mux (
.in0(pc_plus4) , 
.in1(pc_target) ,
.selection(pc_src),
.mux_out(pc_next)
);

sign_extend sign_extend (
.Immed_in(inst[31:7]),
.ImmSrc(ImmSrc),
.imm_extend(imm_extend)

);

store_block #(.data_width(data_width) ) store_logic (
.in(RD2) ,
.store_sel(size_data_sel[1:0]),
.out(write_data)
);

load_memory #(.data_width(data_width)) load_logic (
.in_data (read_data),
.selection(size_data_sel),
.load_data(load_logic_out)
);

mux4_1 #(.data_width(data_width)) Write_back_mux (
.in0(alu_result) , 
.in1(load_logic_out) , 
.in2(pc_plus4) , 
.in3(imm_extend) ,
.selection(result_src),
.mux_out(FB_reg)
);

adder #(.data_width(data_width)) pc_adder_immed (
.op1(pc_addres),
.op2(imm_extend),
.out(pc_target)
);


endmodule