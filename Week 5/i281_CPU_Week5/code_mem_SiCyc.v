module code_memory #(
	parameter DATA_LENGTH=16,
	parameter ADDRESS_SIZE=6
) (
	input [DATA_LENGTH-1:0] wdata,
	input [ADDRESS_SIZE-1:0] rsel, wsel,
	input we, clk,
	output [DATA_LENGTH-1:0] rdata
);
	reg [DATA_LENGTH-1:0] regs [(1<<ADDRESS_SIZE)-1:0];
	
	integer i;
	initial begin
		for(i=0; i< (1<<ADDRESS_SIZE); i=i+1)begin
			regs[i] = 0;
		end

		regs[0]=16'b0011_00_00_00000000; //LOADI A, 0
	//Outer
		regs[1]=16'b1000_11_00_00001000; //LOAD D, [last]
		regs[2]=16'b0011_01_00_00000000; //LOADI B, 0
		regs[3]=16'b1101_00_11_00000000; //CMP A, D
		regs[4]=16'b1111_00_11_00001110; //BRGE End
	//Inner
		regs[5]=16'b1000_11_00_00001000; //LOAD, D, [last]
		regs[6]=16'b0110_11_00_00000000; //SUB D, A
		regs[7]=16'b1101_01_11_00000000; //CMP B, D
		regs[8]=16'b1111_00_11_00001000; //BRGE Iinc
	//If
		regs[9]=16'b1001_10_01_00000000; //LOADF C, [array+B]
		regs[10]=16'b1001_11_01_00000001; //LOADF D, [array+B+1]
		regs[11]=16'b1101_11_10_00000000; //CMP D, C
		regs[12]=16'b1111_00_11_00000010; //BRGE Jinc
	//Swap
		regs[13]=16'b1011_11_01_00000000; //STOREF [array+B], D
		regs[14]=16'b1011_10_01_00000001; //STOREF [array+B+1], C
	//Jinc
		regs[15]=16'b0101_01_00_00000001; //ADDI B, 1
		regs[16]=16'b1110_00_00_11110100; //JUMP Inner
	//Iinc
		regs[17]=16'b0101_00_00_00000001; //ADDI A, 1
		regs[18]=16'b1110_00_00_11101110; //JUMP outer
	//End
		regs[19]=16'b0000_00_00_00000000; //NOOP

	end

	always @(posedge clk)begin
		if(we)begin
			regs[wsel] <= wdata;
		end
	end

	assign rdata = regs[rsel];
endmodule