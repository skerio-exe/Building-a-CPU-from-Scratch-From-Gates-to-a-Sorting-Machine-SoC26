module data_memory #(
	parameter DATA_LENGTH=8,
	parameter ADDRESS_SIZE=4
) (
	input [DATA_LENGTH-1:0] wdata,
	input [ADDRESS_SIZE-1:0] rsel, wsel,
	input we, clk,
	output [DATA_LENGTH-1:0] rdata,
	output [7:0] n1, n2, n3, n4, n5, n6, n7, n8
);
	reg [DATA_LENGTH-1:0] regs [(1<<ADDRESS_SIZE)-1:0];
	
	integer i;
	initial begin
		for(i=0; i< (1<<ADDRESS_SIZE); i=i+1)begin
			regs[i] = 0;
		end

		regs[0] = 7;
		regs[1] = 3;
		regs[2] = 2;
		regs[3] = 1;
		regs[4] = 6;
		regs[5] = 4;
		regs[6] = 5;
		regs[7] = 8;

		regs[8] = 7; //last
		regs[9] = 0; //temp

	end

	always @(posedge clk)begin
		if(we)begin
			regs[wsel] <= wdata;
		end
	end

	assign n1 = regs[0];
	assign n2 = regs[1];
	assign n3 = regs[2];
	assign n4 = regs[3];
	assign n5 = regs[4];
	assign n6 = regs[5];
	assign n7 = regs[6];
	assign n8 = regs[7];
	assign rdata = regs[rsel];
endmodule