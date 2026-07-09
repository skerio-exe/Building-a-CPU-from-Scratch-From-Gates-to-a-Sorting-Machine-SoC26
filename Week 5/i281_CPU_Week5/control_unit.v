module control(
	input [30:0] in,
	output reg [18:1] c
);
//OPCODES from 30:4 -> 26:0, FLAG INPUTS from 3:0;
	always@(*)begin
		c = 18'd0;
		if(in[4])begin
			c[3] = 1;
		end
		else if(in[5])begin //INPUT
			c[1] = 1;
			c[3] = 1;
			c[15] = 1;
		end
		else if(in[6])begin //INPUTCF
			c[1] = 1;
			c[3] = 1;
			c[4] = in[27]; //X1
			c[5] = in[28]; //X0
			c[12:11] = 2'b11;
		end
		else if(in[7])begin //INPUTD
			c[3] = 1;
			c[15] = 1;
			c[16] = 1;
			c[17] = 1;
		end
		else if(in[8])begin //INPUTDF
			c[3] = 1;
			c[4] = in[27];
			c[5] = in[28];
			c[12:11] = 2'b11;
			c[17:16] = 2'b11;
		end
		else if(in[9])begin //MOVE
			c[3] = 1;
			c[4] = in[29]; //Y1
			c[5] = in[30]; //Y0
			c[8] = in[27];
			c[9] = in[28];
			c[12:10] = 3'b111;
		end
		else if(in[10])begin //LOADI_P
			c[3] = 1;
			c[8] = in[27];
			c[9] = in[28];
			c[10] = 1;
			c[15] = 1;
		end
		else if(in[11])begin //ADD
			c[3] = 1;
			c[4] = in[27];
			c[5] = in[28];
			c[6] = in[29];
			c[7] = in[30];
			c[8] = in[27];
			c[9] = in[28];
			c[14:10] = 5'b10101;
		end
		else if(in[12])begin //ADDI
			c[3] = 1;
			c[4] = in[27];
			c[5] = in[28];
			c[8] = in[27];
			c[9] = in[28];
			c[14:10] = 5'b10111;
		end
		else if(in[13])begin //SUB
			c[3] = 1;
			c[4] = in[27];
			c[5] = in[28];
			c[6] = in[29];
			c[7] = in[30];
			c[8] = in[27];
			c[9] = in[28];
			c[14:10] = 5'b11101;
		end
		else if(in[14])begin //SUBI
			c[3] = 0;
			c[4] = in[27];
			c[5] = in[28];
			c[8] = in[27];
			c[9] = in[28];
			c[14:10] = 5'b11111;
		end
		else if(in[15])begin //LOAD
			c[3] = 1;
			c[8] = in[27];
			c[9] = in[28];
			c[10] = 1;
			c[15] = 1;
			c[18] = 1;
		end
		else if(in[16])begin //LOADF
			c[3] = 1;
			c[4] = in[29];
			c[5] = in[30];
			c[8] = in[27];
			c[9] = in[28];
			c[12:10] = 3'b111;
			c[18] = 1;
		end
		else if(in[17])begin //STORE
			c[3] = 1;
			c[6] = in[27];
			c[7] = in[28];
			c[17:15] = 3'b101;
		end
		else if(in[18])begin //STOREF
			c[3] = 1;
			c[4] = in[29];
			c[5] = in[30];
			c[6] = in[27];
			c[7] = in[28];
			c[12:11] = 2'b11;
			c[17] = 1;
		end
		else if(in[19])begin //SHIFTL
			c[3] = 1;
			c[4] = in[27];
			c[5] = in[28];
			c[8] = in[27];
			c[9] = in[28];
			c[14:10] = 5'b10001;
		end
		else if(in[20])begin //SHIFTR
			c[3] = 1;
			c[4] = in[27];
			c[5] = in[28];
			c[8] = in[27];
			c[9] = in[28];
			c[14:10] = 5'b11001;
		end
		else if(in[21])begin //CMP
			c[3] = 1;
			c[4] = in[27];
			c[5] = in[28];
			c[6] = in[29];
			c[7] = in[30];
			c[14:12] = 3'b111;
		end
		else if(in[22])begin //JUMP
			c[3:2] = 2'b11;
		end
		else if(in[23])begin //BRE_Z
			c[3] = 1;
			c[2] = in[0];				//in[0] is zero flag
		end
		else if(in[24])begin //BRNE_Z
			c[3] = 1;
			c[2] = ~in[0];
		end
		else if(in[25])begin //BRG
			c[3] = 1;
			c[2] = (~in[0])&(~(in[2]^in[3])); 	//in[1] carry, in[2] overflow, in[3] negative.
		end
		else if(in[26])begin //BRGE
			c[3] = 1;
			c[2] = ~(in[2]^in[3]);
		end
		else c[3] = 1;
	end
endmodule
