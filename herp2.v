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

// C2 lookahead module
module C2_lookahead(C2,G10,P10,C0);
    input [1:0] G10,P10;
    input C0;
    output C2;
    wire c22, c23; // Terms for C2

    // Get AND terms
    assign 
        c22 = P10[1] & G10[0], // C2 2nd term
        c23 = P10[1] & P10[0] & C0; // C2 3rd term

    // Generate C2
    assign C2 = G10[1] | c22 | c23;
endmodule

module C3_lookahead(C3,G20,P20,C0);
    input [2:0] G20,P20;
    input C0;
    output C3;
    wire c32,c33,c34; // Terms for C3

    // Get AND terms
    assign
        c32 = P20[2] & G20[1], // 2nd term
        c33 = P20[2] & P20[1] & G20[0], // 3rd term
        c34 = P20[2] & P20[1] & P20[0] & C0; // 4th term

    // Generate C3
    assign C3 = G20[2] | c32 | c33 | c34;
endmodule

// Carry-lookahead generator module
module CLA_generator(C62,G50,P50,C0);
    input [5:0] G50,P50;
    input C0;
    output [4:0] C62;
    wire c22,c23; // Terms for C2
    wire c32,c33,c34; // Terms for C3
    wire c42,c43,c44,c45; // Terms for C4
    wire c52,c53,c54,c55,c56; // Terms for C5
    wire c62,c63,c64,c65,c66,c67; // Terms for C6

    /*
    // Terms for C2
    assign 
        c22 = P50[1] & G50[0], // 2nd term
        c23 = P50[1] & P50[0] & C0; // 3rd term

    // Terms for C3
    assign
        c32 = P50[2] & G50[1], // 2nd term
        c33 = P50[2] & P50[1] & G50[0], // 3rd term
        c34 = P50[2] & P50[1] & P50[0] & C0; // 4th term

    // Terms for C4
    assign
        c42 = P50[3] & G50[2],
        c43 = P50[3] & P50[2] & G50[1],
        c44 = P50[3] & P50[2] & P50[1] & G50[0],
        c45 = P50[3] & P50[2] & P50[1] & P50[0] & C0;
    
    // Terms for C5
    assign
        c52 = P50[4] & G50[3],
        c53 = P50[4] & P50[3] & G50[2],
        c54 = P50[4] & P50[3] & P50[2] & G50[1],
        c55 = P50[4] & P50[3] & P50[2] & P50[1] & G50[0],
        c56 = P50[4] & P50[3] & P50[2] & P50[1] & P50[0] & C0;

    // Terms for C6
    assign
        c62 = P50[5] & G50[4],
        c63 = P50[5] & P50[4] & G50[3],
        c64 = P50[5] & P50[4] & P50[3] & G50[2],
        c65 = P50[5] & P50[4] & P50[3] & P50[2] & G50[1],
        c66 = P50[5] & P50[4] & P50[3] & P50[2] & P50[1] & G50[0],
        c67 = P50[5] & P50[4] & P50[3] & P50[2] & P50[1] & P50[0] & C0;
    */
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