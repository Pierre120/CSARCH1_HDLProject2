// Name: Pierre Vincent C. Hernandez, Section: S11
`timescale 1ns / 1ps

// 8-bit Hybrid Adder (2-bit ripple carry_4-bit carry lookahead_2-bit ripple carry) test bench
module hybridadder8_TB();
	reg [7:0] t_X,t_Y;
    reg C0;
    reg [7:0] t_xvals [1:6];
    reg [7:0] t_yvals [1:6];
	wire [7:0] t_S;
    wire C8;
	integer i;
	
	hybridadder8_struct dut(t_S,C8,t_X,t_Y,C0);
	
	initial
		begin
            // test cases
			t_xvals[1] = 8'b11111111; t_yvals[1] = 8'b11111110;
			t_xvals[2] = 8'b10101010; t_yvals[2] = 8'b01010101;
			t_xvals[3] = 8'b00001000; t_yvals[3] = 8'b10000001;
			t_xvals[4] = 8'b00001000; t_yvals[4] = 8'b10000001;
			t_xvals[5] = 8'b00000001; t_yvals[5] = 8'b00000000;
			t_xvals[6] = 8'b11110000; t_yvals[6] = 8'b10001000;

            t_X = 8'b01100000;
            t_Y = 8'b01111111;
            C0 = 1'b0;
			
			for(i=1; i<7; i++) begin
                #10 t_X = t_xvals[i]; t_Y = t_yvals[i];
                    if(i === 4)
                        C0 = 1'b1;
            end

		end
	
	initial // response monitor
		begin
            $display("\nWritten by: Pierre Vincent C. Hernandez");
            $display("8-bit Hybrid Adder Circuit");
            $display("Specification: 2-bit ripple carry_4-bit carry lookahead_2-bit ripple carry");

			$monitor("time = %0d\t", $time, 
                    "X = %b\tY = %b\tC0 = %b\tS = %b C8 = %b",t_X,t_Y,C0,t_S,C8);

			$dumpfile("herp1.vcd");
			$dumpvars;
		end
endmodule