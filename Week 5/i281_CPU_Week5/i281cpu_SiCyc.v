module i281cpu_SiCyc(
	input clk, rst
);
	wire [15:0] switches;
	wire [15:0] code_mem;
	wire [7:0] data_mem;
	wire [26:0] dec_opco;
	wire [18:1] c;
	reg [4:1] bcodes;
	wire [5:0] pc_out;
	wire [7:0] reg_in, reg_out1, reg_out2;
	wire [7:0] alu_in2, alu_out;
	wire zero, carry, overflow, negative;
	wire [7:0] alu_result;
	wire [7:0] DMEM_input_mux_out;

	assign switches = 16'h0000;
	code_memory code_memory_inst(
		.wdata(switches),
		.rsel(pc_out), 
		.wsel(alu_result[5:0]),
		.we(c[1]),
		.clk(clk),
		.rdata(code_mem)
	);

	wire [7:0] n1, n2, n3, n4, n5, n6, n7, n8;

	data_memory data_memory_inst(
		.wdata(DMEM_input_mux_out),
		.rsel(alu_result[3:0]),
		.wsel(alu_result[3:0]),
		.we(c[17]),
		.clk(clk),
		.rdata(data_mem),
		.n1(n1),
		.n2(n2),
		.n3(n3),
		.n4(n4),
		.n5(n5),
		.n6(n6),
		.n7(n7),
		.n8(n8)
	);

	decoder Opcode(
		.c(code_mem[15:8]),
		.en(1'b1),
		.out(dec_opco)
	);

	control control_inst(
		.in({dec_opco, bcodes}),
		.c(c)
	);
	
	pc program_counter(
		.clk(clk), 
		.rst(rst), 
		.inc(c[3]), 
		.load(c[2]), 
		.offset_val(code_mem[5:0]), 
		.pc_out(pc_out)
	);

	regfile reg_inst(
		.clk(clk),
		.we(c[10]), 
		.raddr0({c[4], c[5]}), 
		.raddr1({c[6], c[7]}), 
		.waddr({c[8], c[9]}), 
		.wdata(reg_in), 
		.rdata0(reg_out1), 
		.rdata1(reg_out2)
	);

	mux2 #(.WIDTH(8)) ALU_source_mux(
		.a(reg_out2), 
		.b(code_mem[7:0]), 
		.sel(c[11]), 
		.y(alu_in2)
	);

	alu ALU(
		.a(reg_out1),
		.b(alu_in2),
		.op({c[12], c[13]}),
		.result(alu_out),
		.zero(zero),
		.carry(carry),
		.overflow(overflow),
		.negative(negative)
	);

	always@(posedge clk)begin
		if(rst)begin
			bcodes <= 4'b0000;
		end
		else if(c[14])begin
			bcodes[1] <= zero;
			bcodes[2] <= carry;
			bcodes[3] <= overflow;
			bcodes[4] <= negative;
		end
	end

	mux2 #(.WIDTH(8)) ALU_result_mux(
		.a(alu_out), 
		.b(code_mem[7:0]), 
		.sel(c[15]), 
		.y(alu_result)
	);

	mux2 #(.WIDTH(8)) DMEM_input_mux(
		.a(reg_out2), 
		.b(switches[7:0]), 
		.sel(c[16]), 
		.y(DMEM_input_mux_out)
	);

	mux2 #(.WIDTH(8)) REG_writeback_mux(
		.a(alu_result),
		.b(data_mem), 
		.sel(c[18]), 
		.y(reg_in)
	);
endmodule