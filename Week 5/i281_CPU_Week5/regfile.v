module regfile(
    input        clk, we,
    input  [1:0] raddr0, raddr1, waddr,
    input  [7:0] wdata,
    output [7:0] rdata0, rdata1
);
    reg [7:0] regs [3:0];	 //4 registers, each 8 bits wide
    initial begin
	regs[0] = 8'h00;
	regs[1] = 8'h00;
	regs[2] = 8'h00;
	regs[3] = 8'h00;
    end

    always @(posedge clk) begin
        if (we)
            regs[waddr] <= wdata;
    end

    assign rdata0 = regs[raddr0];
    assign rdata1 = regs[raddr1];

endmodule