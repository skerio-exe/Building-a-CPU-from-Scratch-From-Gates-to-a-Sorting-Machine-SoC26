module decoder(
	input [15:8] c,
	input en,
	output reg [26:0] out
);

	parameter NOOP = 1, INPUTC = 2, INPUTCF = INPUTC*2, INPUTD = INPUTCF*2, INPUTDF = INPUTD*2,
		MOVE = INPUTDF*2, LOADI_P = MOVE*2, ADD = LOADI_P*2, ADDI = ADD*2, SUB = ADDI*2, SUBI = SUB*2,
		LOAD = SUBI*2, LOADF = LOAD*2, STORE = LOADF*2, STOREF = STORE*2, SHIFTL = STOREF*2, SHIFTR = SHIFTL*2,
		CMP = SHIFTR*2, JUMP = CMP*2, BRE_BRZ = JUMP*2, BRNE_BRNZ = JUMP*4, BRG = JUMP*8, BRGE = JUMP*16;


	always@(*) begin
		out = 27'b0;
		out[23] = c[11]; //X1
		out[24] = c[10]; //X0
		out[25] = c[9]; //Y1
		out[26] = c[8]; //Y0

		case(c[15:12])
			0: out[22:0] = NOOP;
			1: case(c[9:8])
				0: out[22:0] = INPUTC;
				1: out[22:0] = INPUTCF;
				2: out[22:0] = INPUTD;
				3: out[22:0] = INPUTDF;
			endcase
			2: out[22:0] = MOVE;
			3: out[22:0] = LOADI_P;
			4: out[22:0] = ADD;
			5: out[22:0] = ADDI;
			6: out[22:0] = SUB;
			7: out[22:0] = SUBI;
			8: out[22:0] = LOAD;
			9: out[22:0] = LOADF;
			10: out[22:0] = STORE;
			11: out[22:0] = STOREF;
			12: case(c[8])
				0: out[22:0] = SHIFTL;
				1: out[22:0] = SHIFTR;
			endcase
			13: out[22:0] = CMP;
			14: out[22:0] = JUMP;
			15: case(c[9:8])
				0: out[22:0] = BRE_BRZ;
				1: out[22:0] = BRNE_BRNZ;
				2: out[22:0] = BRG;
				3: out[22:0] = BRGE;
			endcase
		endcase
	end
endmodule



