module pc(
    input            clk, rst, inc, load,
    input      [5:0] offset_val,
    output reg [5:0] pc_out
);
    always @(posedge clk) begin
	if (rst)
		pc_out = 0;
	else if (load)
		pc_out = pc_out + offset_val + 1'b1;
	else if (inc)
		pc_out = pc_out + 1'b1;
    end
endmodule