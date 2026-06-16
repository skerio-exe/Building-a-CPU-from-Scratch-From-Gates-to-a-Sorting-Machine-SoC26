module tb_decoder;
	reg[15:0] c;
	reg en;
	wire [26:0] out;
	integer fail = 0;


	decoder instance1(c, en, out);

	parameter NOOP = 1, INPUTC = 2, INPUTCF = INPUTC*2, INPUTD = INPUTCF*2, INPUTDF = INPUTD*2,
		MOVE = INPUTDF*2, LOADI_P = MOVE*2, ADD = LOADI_P*2, ADDI = ADD*2, SUB = ADDI*2, SUBI = SUB*2,
		LOAD = SUBI*2, LOADF = LOAD*2, STORE = LOADF*2, STOREF = STORE*2, SHIFTL = STOREF*2, SHIFTR = SHIFTL*2,
		CMP = SHIFTR*2, JUMP = CMP*2, BRE_BRZ = JUMP*2, BRNE_BRNZ = JUMP*4, BRG = JUMP*8, BRGE = JUMP*16;


	initial begin
		$dumpfile("wave_mux.vcd"); $dumpvars(0,tb_decoder);
		en = 0; c = 16'h0000;

		c = 16'h0500;  #10;
        	if(out!==NOOP) begin $display("FAIL decoder NOOP"); fail=fail+1; end
        	c = 16'h1000; #10;
        	if(out!==INPUTC) begin $display("FAIL decoder INPUTC"); fail=fail+1; end
        	c = 16'h1300; #10;
        	if(out!==INPUTDF) begin $display("FAIL decoder INPUTDF"); fail=fail+1; end
        	c = 16'h4A00; #10;
        	if(out!==ADD) begin $display("FAIL decoder ADD"); fail=fail+1; end
        	c = 16'h7F00; #10;
        	if(out!==SUBI) begin $display("FAIL decoder SUBI"); fail=fail+1; end
        	c = 16'hC000; #10;
        	if(out!==SHIFTL) begin $display("FAIL decoder SHIFTL"); fail=fail+1; end
        	c = 16'hF200; #10;
        	if(out!==BRG) begin $display("FAIL decoder BRG"); fail=fail+1; end


                if(fail==0) $display("PASS — all decoder checks passed.");
        	else        $display("FAIL — %0d check(s) failed.", fail);
        	$finish;
	end
endmodule

