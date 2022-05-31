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
module Full_adder(S,C,X,Y,Z);
    input X,Y;
    output S,C;
    wire S1,C1,C2;

    half_adder H1(S1,C1,X,Y);
    half_adder H2(S,C2,S1,Z);
    assign C = C2 | C1;
endmodule

// Full-Adder (no carry) module
module Full_adder_nc(S,X,Y,Z);
    input X,Y;
    output S;
    wire S1,C1,C2;

    half_adder H1(S1,C1,X,Y);
    half_adder H2(S,C2,S1,Z);
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
module CLA_generator(C62,G50,P50,C0);
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

module Sumer(Si,Pi,Ci);
    input Pi,Ci;
    output Si;

    assign Si = Pi ^ Ci;
endmodule

// Main module
module hybridadder8_struct(Si,C8,Xi,Yi,C0);
    input [7:0] Xi,Yi;
    input C0;
    output [7:0] Si;
    output C8;
    wire [5:0] P,G;
    wire [4:0] C62;
    wire C1,C7;

    // Generate the P_(5-0) and G_(5-0)
    PG_generator PG(P,G,X[5:0],Y[5:0]);

    // Generate the carries from carry-lookahead generator
    CLA_generator CLA(C62,G,P,C0);

    // Full-adders for S0 and S1
    Full_adder S0(Si[0],);
endmodule