// Name: Pierre Vincent C. Hernandez, Section: S11
`timescale 1ns / 1ps

// Half-Adder module
module half_adder(S,C,X,Y);
    input X,Y;
    output S,C;

    assign S = X ^ Y;
    assign C = X & Y
endmodule

// Full-Adder module
module full_adder(S,C,X,Y,Z);
    input X,Y;
    output S,C;
    wire S1,C1,C2;

    half_adder H1(S1,C1,X,Y);
    half_adder H2(S,C2,S1,Z);
    assign C = C2 | C1;
endmodule

// P and G generator module
module PG_generator(P,G,X,Y);
    input [5:0] X,Y;
    output [5:0] P,G;

    assign P = X ^ Y; // carry propagate
    assign G = X & Y; // carry generate
endmodule

// C_(i+1) module
module carry_lookahead(Ci1,Gi,Pi,Ci);
    input Gi,Pi,Ci;
    output Ci1;

    assign Ci1 = Gi | (Pi & Ci);
endmodule

// Carry-lookahead generator module
module cla_generator(C62,G50,P50,C0);
    input [5:0] G50,P50;
    input C0;
    output [4:0] C62;
    wire C;

    // Geting C_(6-2)
    carry_lookahead 
        C1(C,G50[0],P50[0],C0),
        C2(C62[0],G50[1],P50[1],C),
        C3(C62[1],G50[2],P50[2],C62[0]),
        C4(C62[2],G50[3],P50[3],C62[1]),
        C5(C62[3],G50[4],P50[4],C62[2]),
        C6(C62[4],G50[5],P50[5],C62[3]);
endmodule

module sumer(Si,Pi,Ci);
    input Pi,Ci;
    output Si;

    assign Si = Pi ^ Ci;
endmodule

// Main module
module hybridadder8_struct(S,C8,X,Y,C0);
    input [7:0] X,Y;
    input C0;
    output [7:0] S;
    output C8;
    wire [5:0] P,G;
    wire [4:0] C62;

    
endmodule