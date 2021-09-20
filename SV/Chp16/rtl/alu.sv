//
// Verilog Module Chp05_Cdns_SV_lib.alu
//
// Created:
//          by - cnutsukpui.cnutsukpui (ChrisNutsukpui)
//          at - 11:27:53 08/12/21
//
// using Mentor Graphics HDL Designer(TM) 2020.4 Built on 12 Oct 2020 at 16:52:03
//

`resetall
`timescale 1ns/10ps
module alu import typedefs::*;(
    output logic [7:0] out, 
    output logic zero, 
    input logic [7:0] accum, data, 
    input opcode_t opcode, 
    input logic clk
);
    logic [7:0] out_D;
    always_comb begin : alu_omb
        priority case(opcode)
            HLT: out_D = accum;
            SKZ: out_D = accum; 
            ADD: out_D = data + accum;
            AND: out_D = data & accum;
            XOR: out_D = data ^ accum;
            LDA: out_D = data; 
            STO: out_D = accum;
            JMP: out_D = accum;
        endcase
    end

    always_ff @( negedge clk ) begin : clk_out
        out <= out_D;
    end

    assign zero = (accum == 8'h00) ? 1'b1 : 1'b0; 

// ### Please start your Verilog code here ### 

endmodule
