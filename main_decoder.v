module main_decoder (
input	wire	[6:0] 	op_code ,

output	reg				reg_write , alu_src_B , alu_src_A , mem_write  ,branch , jump , LD_ST_op,
output	reg		[2:0]	imm_src , 
output 	reg		[1:0]	alu_op , result_src 

);

always @(*)
begin
	LD_ST_op = 1'b0 ;
	case (op_code)
		'd51 : //R_type
		begin
			imm_src		= 'bx  ;
			reg_write 	= 1'b1 ;
			alu_src_B 	= 1'b0 ;
			alu_src_A	= 1'b0 ;
			mem_write 	= 1'b0 ;
			result_src	= 'b00 ;
			branch		= 1'b0 ;	
			jump		= 1'b0 ;
			alu_op		= 'b10 ;
		end
		
		'd19 : //I_type 
		begin
			imm_src		= 'b000 ;
			reg_write 	= 1'b1 ;
			alu_src_B	= 1'b1 ;
			alu_src_A	= 1'b0 ;
			mem_write 	= 1'b0 ;
			result_src	= 'b00 ;
			branch		= 1'b0 ;	
			jump		= 1'b0 ;
			alu_op		= 'b10 ;
		end
		
		'd3 : //I_type load 
		begin
			reg_write 	= 1'b1 ;
			imm_src		= 'b000 ;	
			alu_src_B	= 1'b1 ;
			alu_src_A	= 1'b0 ;
			mem_write 	= 1'b0 ;
			result_src	= 'b01 ;
			branch		= 1'b0 ;	
			jump		= 1'b0 ;
			alu_op		= 'b00 ;
			LD_ST_op    = 1'b1 ;

		end
		/*
		'd19 : //I_type
		begin
			reg_write 	= 1'b1 ;
			imm_src		= 'b000 ;	
			alu_src_B	= 1'b1 ;
			alu_src_A	= 1'b0 ;
			mem_write 	= 1'b0 ;
			result_src	= 'b01 ;
			branch		= 1'b0 ;	
			jump		= 1'b0 ;
			alu_op		= 'b00 ;
		end
		*/
		'd99 : //B_type
			begin
			reg_write 	= 1'b0 ;
			imm_src		= 'b010 ;	
			alu_src_B 	= 1'b0 ;
			alu_src_A	= 1'b0 ;
			mem_write 	= 1'b0 ;
			result_src	= 'bxx ;
			branch		= 1'b1 ;	
			jump		= 1'b0 ;
			alu_op		= 'b01 ;
		end
		
		'd111 : //J_type jal inst
			begin
			reg_write 	= 1'b1 ;
			imm_src		= 'b011 ;	
			alu_src_B	= 1'b1 ;
			alu_src_A	= 1'b1 ;
			mem_write 	= 1'b0 ;
			result_src	= 'b10 ;
			branch		= 1'b0 ;	
			jump		= 1'b1 ;
			alu_op		= 'b00 ;
		end
		
		'd103 : //JALR inst I_type , jump and link register
			begin
			reg_write 	= 1'b1 ;
			imm_src		= 'b000 ;	
			alu_src_B	= 1'b1 ;
			alu_src_A	= 1'b0 ;
			mem_write 	= 1'b0 ;
			result_src	= 'b10 ;
			branch		= 1'b0 ;	
			jump		= 1'b1 ;
			alu_op		= 'b00 ;
		end
		
		'd55 : //load upper immediate
			begin
			reg_write 	= 1'b1 ;
			imm_src		= 'b100 ;	
			alu_src_B	= 1'bx ;
			alu_src_A	= 1'bx ;
			mem_write 	= 1'b0 ;
			result_src	= 'b11 ;
			branch		= 1'b0 ;	
			jump		= 1'b0 ;
			alu_op		= 'bxx ;
		end
		
		'd23 : //add upper immediate to pc
			begin
			reg_write 	= 1'b1 ;
			imm_src		= 'b100 ;	
			alu_src_B	= 1'b1 ;
			alu_src_A	= 1'b1 ;
			mem_write 	= 1'b0 ;
			result_src	= 'b00 ;
			branch		= 1'b0 ;	
			jump		= 1'b0 ;
			alu_op		= 'b00 ;
		end
		
		'd35 : //S_Type store in memory
			begin
			reg_write 	= 1'b0 ;
			imm_src		= 'b001 ;	
			alu_src_B	= 1'b1 ;
			alu_src_A	= 1'b0 ;
			mem_write 	= 1'b1 ;
			result_src	= 'bxx ;
			branch		= 1'b0 ;	
			jump		= 1'b0 ;
			alu_op		= 'b00 ;
			LD_ST_op    = 1'b1 ;

		end

	endcase

end

endmodule