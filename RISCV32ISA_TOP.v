module ricsV_top (
input	wire	clk,rst

);

parameter data_width = 32 ;
parameter address_bits = 32 ;

wire	[31:0]		inst , Read_Data ;
wire				Reg_Write,Pc_Src , Alu_Src_A , Alu_Src_B ,Mem_Write ;
wire	[1:0]		Result_Src ;
wire	[2:0]	    Imm_Src , Size_Data_Sel ;
wire	[3:0]		Alu_Control ;
wire	[31:0]		Pc , Data_address , Write_Data ;
wire				zero_flag , SLT_flag , SLTu_fla;

data_path DataPath (
.inst(inst) , 
.read_data(Read_Data) ,
.reg_write(Reg_Write) , 
.pc_src(Pc_Src) , 
.alu_src_B(Alu_Src_B) , 
.alu_src_A(Alu_Src_A) , 
.result_src(Result_Src),
.alu_control(Alu_Control) , 
.ImmSrc(Imm_Src) , 
.size_data_sel(Size_Data_Sel) ,
.clk(clk),
.rst(rst),
.pc_addres(Pc) , 
.alu_result(Data_address) , 
.write_data(Write_Data) ,
.zero_flag(zero_flag) , 
.SLT_flag(SLT_flag) , 
.SLTu_flag(SLTu_flag)
);

top_decode Controller (
.inst(inst) ,
.zero_flag(zero_flag) , 
.SLT_flag(SLT_flag) , 
.SLTu_flag(SLTu_flag) ,
.reg_write(Reg_Write) , 
.mem_write(Mem_Write) , 
.pc_src(Pc_Src),
.alu_src_B(Alu_Src_B) , 
.alu_src_A(Alu_Src_A) ,
.ImmSrc(Imm_Src) , 
.alu_control(Alu_Control),
.result_src(Result_Src), 
.size_data_sel(Size_Data_Sel)	
);

Ram #( .data_width(data_width) ,.address_bits(address_bits)) RAM (
.address(Data_address) ,
.WD (Write_Data),
.WE (Mem_Write), 
.clk(clk) ,
.RD(Read_Data) 
);

ROM #(.instruction_width(data_width) ) Rom (
.addres (Pc),
.inst (inst) 
);


endmodule