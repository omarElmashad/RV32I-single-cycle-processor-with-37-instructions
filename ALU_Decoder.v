module alu_decoder (
input 	wire	[6:0]	op_code ,
input	wire	[2:0]	func3 ,
input	wire	[1:0]	alu_op ,
input	wire			func7_bit5 ,

output	reg		[3:0]	alu_control
);

wire	I_type_flag ;

assign I_type_flag = (op_code == 'd19) ;
always @(*)
begin
	case(alu_op)
	2'b00:alu_control = 'd0 ; //addition //if load or store or jal or jalr or auipc

	2'b01: //if B_tupe (beq , bnq , blt , bgt ,bltu , bgtu)
	begin
		case (func3)
		3'b000:alu_control = 'd1 ;//sub //beq
		3'b001:alu_control = 'd1 ;//bnq
		3'b100:alu_control = 'd8 ;//blt
		3'b101:alu_control = 'd8 ;//bgt
		3'b110:alu_control = 'd9 ;//bltu
		3'b111:alu_control = 'd9 ;//bgtu
		default : alu_control = 'dx;
		endcase
	end
	
	2'b10://r and I type
	begin	
		case (func3)
		3'b000:alu_control = ( (!I_type_flag & func7_bit5) ? 'd1 : 'd0 ) ;//add , sub or addi 
		3'b001:alu_control = 'd1 ;//sll or slli
		3'b010:alu_control = 'd8 ;//slt or slti
		3'b011:alu_control = 'd9 ;//sltu or sltu
		3'b100:alu_control = 'd7 ;//xor or xori
		3'b101:alu_control = (func7_bit5 ? 'd6 : 'd5 ) ;//srl or srlu or sra or srai
		3'b110:alu_control = 'd3 ;//or , ori
		3'b111:alu_control = 'd2 ;//and , andi
		default : alu_control = 'dx;
		endcase
	end

	default: alu_control = 'dx ;

	
	endcase

end

endmodule