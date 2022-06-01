// Name: Pierre Vincent C. Hernandez, Section: S11
`timescale 1ns / 1ps

// Half-Adder module
module half_adder(S,C,X,Y);
    input X,Y;
    output S,C;

    assign S = X ^ Y; // XOR Gate
    assign C = X & Y; // AND Gate
endmodule

// Full-Adder module
module Full_adder(S,C,X,Y,Z);
    input X,Y,Z; 
    output S,C;
    wire S1,C1,C2;

    half_adder H1(S1,C1,X,Y);
    half_adder H2(S,C2,S1,Z);
    assign C = C2 | C1; // OR Gate
endmodule

// Full-Adder (no carry) module
module Full_adder_nc(S,X,Y,Z);
    input X,Y,Z;
    output S;

    // 2 XOR Gates
    S = (X ^ Y) ^ Z;
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

// C3 lookahead module
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

// C4 lookahead module
module C4_lookahead(C4,G30,P30,C0);
    input [3:0] G30,P30;
    input C0;
    output C4;
    wire c42,c43,c44,c45; // Terms for C4

    // Get AND terms
    assign
        c42 = P30[3] & G30[2], // 2nd term
        c43 = P30[3] & P30[2] & G30[1], // 3rd term
        c44 = P30[3] & P30[2] & P30[1] & G30[0], // 4th term
        c45 = P30[3] & P30[2] & P30[1] & P30[0] & C0; // 5th term

    // Generate C4
    assign C4 = G30[3] | c42 | c43 | c44 | c45;
endmodule

// C5 lookahead module
module C5_lookahead(C5,G40,P40,C0);
    input [4:0] G40,P40;
    input C0;
    output C5;
    wire c52,c53,c54,c55,c56; // Terms for C5

    // Get AND terms
    assign
        c52 = P40[4] & G40[3], // 2nd term
        c53 = P40[4] & P40[3] & G40[2], // 3rd term
        c54 = P40[4] & P40[3] & P40[2] & G40[1], // 4th term
        c55 = P40[4] & P40[3] & P40[2] & P40[1] & G40[0], // 5th term
        c56 = P40[4] & P40[3] & P40[2] & P40[1] & P40[0] & C0; // 6th term

    // Generate C5
    assign C5 = G40[4] | c52 | c53 | c54 | c55 | c56;
endmodule

// C6 lookahead module
module C6_lookahead(C6,G50,P50,C0);
    input [5:0] G50,P50;
    input C0;
    output C6;
    wire c62,c63,c64,c65,c66,c67; // Terms for C6

    // Get AND terms
    assign
        c62 = P50[5] & G50[4], // 2nd term
        c63 = P50[5] & P50[4] & G50[3], // 3rd term
        c64 = P50[5] & P50[4] & P50[3] & G50[2], // 4th term
        c65 = P50[5] & P50[4] & P50[3] & P50[2] & G50[1], // 5th term
        c66 = P50[5] & P50[4] & P50[3] & P50[2] & P50[1] & G50[0], // 6th term
        c67 = P50[5] & P50[4] & P50[3] & P50[2] & P50[1] & P50[0] & C0; // 7th term

    // Generate C6
    assign C6 = G50[5] | c62 | c63 | c64 | c65 | c66 | c67;
endmodule

// For generating the AND terms of each carry
module carry_ANDs(C2T,C3T,C4T,C5T,C6T,G,P,C0);
    input [5:0] G,P;
    input C0;
    output [1:0] C2T; // AND terms for C2
    output [2:0] C3T; // AND terms for C3
    output [3:0] C4T; // AND terms for C4
    output [4:0] C5T; // AND terms for C5
    output [5:0] C6T; // AND terms for C6

    // Get all the AND terms for each carry
    assign
        C2T[1] = P[1] & G[0], // C2 2nd term
        C2T[0] = P[1] & P[0] & C0, // C2 3rd term
        C3T[2] = P[2] & G[1], // C3 2nd term
        C3T[1] = P[2] & P[1] & G[0], // C3 3rd term
        C3T[0] = P[2] & P[1] & P[0] & C0, // C3 4th term
        C4T[3] = P[3] & G[2], // C4 2nd term
        C4T[2] = P[3] & P[2] & G[1], // C4 3rd term
        C4T[1] = P[3] & P[2] & P[1] & G[0], // C4 4th term
        C4T[0] = P[3] & P[2] & P[1] & P[0] & C0, // C4 5th term
        C5T[4] = P[4] & G[3], // C5 2nd term
        C5T[3] = P[4] & P[3] & G[2], // C5 3rd term
        C5T[2] = P[4] & P[3] & P[2] & G[1], // C5 4th term
        C5T[1] = P[4] & P[3] & P[2] & P[1] & G[0], // C5 5th term
        C5T[0] = P[4] & P[3] & P[2] & P[1] & P[0] & C0, // C5 6th term
        C6T[5] = P[5] & G[4], // C6 2nd term
        C6T[4] = P[5] & P[4] & G[3], // C6 3rd term
        C6T[3] = P[5] & P[4] & P[3] & G[2], // C6 4th term
        C6T[2] = P[5] & P[4] & P[3] & P[2] & G[1], // C6 5th term
        C6T[1] = P[5] & P[4] & P[3] & P[2] & P[1] & G[0], // C6 6th term
        C6T[0] = P[5] & P[4] & P[3] & P[2] & P[1] & P[0] & C0; // C6 7th term
endmodule

// Carry-lookahead generator module
module CLA_generator(C62,G50,P50,C0);
    input [5:0] G50,P50;
    input C0;
    output [4:0] C62;
    wire [1:0] C2T; // AND terms for C2
    wire [2:0] C3T; // AND terms for C3
    wire [3:0] C4T; // AND terms for C4
    wire [4:0] C5T; // AND terms for C5
    wire [5:0] C6T; // AND terms for C6

    // Get AND terms of each carry
    carry_ANDs CANDs(C2T,C3T,C4T,C5T,C6T,G50,P50,C0);

    // OR gate the AND terms of each carry to get the carry
    assign
        C62[0] = G50[1] | C2T[1] | C2T[0], // C2
        C62[1] = G50[2] | C3T[2] | C3T[1] | C3T[0], // C3
        C62[2] = G50[3] | C4T[3] | C4T[2] | C4T[1] | C4T[0], // C4
        C62[3] = G50[4] | C5T[4] | C5T[3] | C5T[2] | C5T[1] | C5T[0], // C5
        C62[4] = G50[5] | C6T[5] | C6T[4] | C6T[3] | C6T[2] | C6T[1] | C6T[0]; // C6

    /*
    // Generate carries
    C2_lookahead C2(C62[0],G50[1:0],P50[1:0],C0);
    C3_lookahead C3(C62[1],G50[2:0],P50[2:0],C0);
    C4_lookahead C4(C62[2],G50[3:0],P50[3:0],C0);
    C5_lookahead C5(C62[3],G50[4:0],P50[4:0],C0);
    C6_lookahead C6(C62[4],G50,P50,C0);
    */
    /*
    wire c22,c23; // Terms for C2
    wire c32,c33,c34; // Terms for C3
    wire c42,c43,c44,c45; // Terms for C4
    wire c52,c53,c54,c55,c56; // Terms for C5
    wire c62,c63,c64,c65,c66,c67; // Terms for C6

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

// Sumer module
module Sumer(Si,Pi,Ci);
    input Pi,Ci;
    output Si;

    // 1 XOR Gate
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
    PG_generator PG(P,G,Xi[5:0],Yi[5:0]);

    // Generate the carries from carry-lookahead generator
    CLA_generator CLA(C62,G,P,C0);

    // Full-adders for S0 and S1
    Full_adder      S0(Si[0],C1,Xi[0],Yi[0],C0);
    Full_adder_nc   S1(Si[1],Xi[1],Yi[1],C1);

    // Sumers for S2 to S5
    Sumer S2(Si[2],P[2],C62[0]); // C2
    Sumer S3(Si[3],P[3],C62[1]); // C3
    Sumer S4(Si[4],P[4],C62[2]); // C4
    Sumer S5(Si[5],P[5],C62[3]); // C5

    // Full-adders for S7 and S8
    Full_adder S6(Si[6],C7,Xi[6],Yi[6],C62[4]); // C6
    Full_adder S7(Si[7],C8,Xi[7],Yi[7],C7);
endmodule
