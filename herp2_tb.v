// Name: Pierre Vincent C. Hernandez, Section: S11
`timescale 1ns / 1ps

// 8-bit Hybrid Adder (2-bit ripple carry_4-bit carry lookahead_2-bit ripple carry) test bench
module hybridadder8_TB();
	reg [7:0] t_X,t_Y;
    reg C0;
	wire [7:0] t_S;
    wire C8;
	integer i;
	
	mux41_gate dut(t_Y,t_A,t_B,t_C,t_D,t_S[1],t_S[0]);
	
	initial
		begin
			t_S = 2'b00;
			t_A = 1'b1;
			t_B = 1'b0;
			t_C = 1'b1;
			t_D = 1'b0;
			
			for(i=1; i<4; i++)
			#10 t_S = i;
		end
	
	initial // response monitor
		begin
            $display("\nWritten by: Pierre Vincent C. Hernandez");
            $display("8-bit Hybrid Adder Circuit");
            $display("Specification: 2-bit ripple carry_4-bit carry lookahead_2-bit ripple carry");

			$monitor("time = %0d ", $time, "Selector = %b output_Y = %b",t_S,t_Y);
            
			$dumpfile("herp1.vcd");
			$dumpvars;
		end
endmodule