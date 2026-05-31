// Week 2 — 8-bit ALU
// op: 000=ADD 001=SUB 010=AND 011=OR 100=XOR 101=SHIFTL 110=SHIFTR
// Run: iverilog -o sim ../testbenches/tb_alu.v alu.v && vvp sim

module alu(
    input  [7:0]     a, b,
    input  [2:0]     op,
    output reg [7:0] result,
    output reg       zero,
    output reg       carry,
    output reg       overflow
);
	reg [8:0] temp;
	always @(a, b, op) begin
		result = 8'b0;
		temp = 9'b0;
		carry = 1'b0;
		overflow = 1'b0;

		case(op)
			0: begin
				temp = a + b;
                		result   = temp[7:0];
                		carry    = temp[8];
                		overflow = (a[7] == b[7]) && (result[7] != a[7]);
			end
			1: begin
				temp = a - b;
                		result   = temp[7:0];
                		carry    = temp[8];
                		overflow = (a[7] != b[7]) && (result[7] != a[7]);
			end
			2: result = a&b;
			3: result = a|b;
			4: result = a^b;
			5: begin	
				result = a<<1;
				carry = a[7];
			end
			6: begin
				result = a>>1;
				carry = a[0];
			end
			default: result = 8'b0;
		endcase
	assign zero = (result == 8'b0) ? 1'b1 : 1'b0;
	end
endmodule
