`timescale 1ns/1ps

module RV_TB ();

reg	clk,rst ;

parameter clk_period = 10 ;

always #(clk_period/2) clk = !clk ;


ricsV_top DUT (
.clk(clk),
.rst(rst)
);

initial 
begin
clk = 1'b0 ;
rst = 1'b1 ;
#clk_period
rst = 1'b0;
#clk_period
rst = 1'b1;

end

always @(negedge clk )
begin
	if(DUT.Controller.mem_write)
	begin
		if ( DUT.DataPath.alu_result == 'd100 && DUT.DataPath.write_data == 'd25  )
		begin
			$display ("Simulation succeeded") ;
			#clk_period
			$stop;
		end	
		else if( DUT.DataPath.alu_result != 'd96)
		begin
		$display ("Simulation faild") ;
			#clk_period
			$stop;
		end
	end
end


endmodule