`timescale 1ns / 1ns

module tb_i281_cpu_SiCyc();
	reg clk, rst;
	wire switches[15:0];
	
	i281cpu_SiCyc uut(.clk(clk), .rst(rst));

	always begin
		#10 clk=~clk;
	end

	integer i;

	initial begin
		$dumpfile("i281_sicyc_bubblesort.vcd"); $dumpvars(0,tb_i281_cpu_SiCyc);

		clk = 0;
		rst = 1;

		#45

		rst = 0;

		$display("Unsorted array:");
		for(i=0; i<8; i=i+1)begin
			$display("array[%0d] = %0d", i, uut.data_memory_inst.regs[i]);
		end
		
		#250000

		$display("Sorted array:");
		for(i=0; i<8; i=i+1)begin
			$display("array[%0d] = %0d", i, uut.data_memory_inst.regs[i]);
		end

		$finish;
	end

endmodule