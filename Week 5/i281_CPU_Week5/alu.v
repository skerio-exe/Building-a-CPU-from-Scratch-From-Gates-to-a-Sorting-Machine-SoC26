module alu(
    input  [7:0]     a, b,
    input  [1:0]     op,
    output reg [7:0] result,
    output reg       zero,
    output reg       carry,
    output reg       overflow,
    output reg       negative
);
	reg [8:0] temp;
	always @(*) begin
		result = 8'b0;
		temp = 9'b0;
		carry = 1'b0;
		overflow = 1'b0;
		negative = 1'b0;

		case(op)
			0: begin	
				result = a<<1;
				carry = a[7];
			end
			1: begin
				result = a>>1;
				carry = a[0];
			end
			2: begin
				temp = a + b;
                		result   = temp[7:0];
                		carry    = temp[8];
                		overflow = (a[7] == b[7]) && (result[7] != a[7]);
			end
			3: begin
				temp = a - b;
                		result   = temp[7:0];
                		carry    = temp[8];
                		overflow = (a[7] != b[7]) && (result[7] != a[7]);
			end
			default: result = 8'b0;
		endcase
		zero = (result == 8'b0) ? 1'b1 : 1'b0;
		negative = result[7];
	end
endmodule