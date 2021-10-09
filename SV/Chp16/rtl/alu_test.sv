///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : alu_test.sv
// Title       : ALU Testbench Module
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Defines the ALU testbench module
// Notes       :
// 
///////////////////////////////////////////////////////////////////////////

// package with opcode_t declaration


module alu_test;
import typedefs::*;
// SystemVerilog: time unit and time precision specification
timeunit 1ns;
timeprecision 100ps;

// SystemVerilog: logic and enumeration and user-defined data types
logic  [7:0] accum, data, out;
logic  zero;

opcode_t  opcode = HLT;

// ---- clock generator code begin------
`define PERIOD 10
logic clk = 1'b1;

always
    #(`PERIOD/2)clk = ~clk;

// ---- clock generator code end------

alu      alu1  (.out(out), .zero(zero), .clk(clk), .accum(accum), .data(data), .opcode(opcode));

  // Verify Response
  task checkit (input [8:0] expects ) ;
    begin
      $display ( "%t opcode=%s data=%h accum=%h | zero=%b out=%h",
	        $time, opcode.name(), data, accum, zero, out);
      if ({zero, out} !== expects )
        begin
          $display ( "zero:%b  out:%b  s/b:%b_%b", zero, out,
                      expects[8], expects[7:0] );
          $display ( "ALU TEST FAILED" );
          $finish;
        end
    end
  endtask

covergroup cpa @(posedge clk); 
  c1: coverpoint opcode;
  c1_re : coverpoint opcode {
    bins op_data [] = {[ADD:LDA]};
    // bins op_data_only = {LDA};
    bins op_accum [] = {STO,JMP, HLT, SKZ};
  }

  c2: coverpoint data{
      bins high = {[128:$]}; 
      bins low  = {[0:127]};
  } 
  c3: coverpoint accum{
      bins high = {[128:$]}; 
      bins low  = {[0:127]};
  }

   opXdata  : cross c1_re, c2{
      ignore_bins b2 = binsof(c1_re.op_accum);
      ignore_bins b1 = binsof(c1_re.op_data) intersect {[ADD:XOR]}; 
   }
   opXaccum : cross c1_re, c3{
     ignore_bins b1 = binsof(c1_re.op_data);
   }

   opXdataXaccum : cross c1_re, c2, c3 {
      ignore_bins b1 = binsof(c1_re.op_accum) || binsof(c1_re.op_data) intersect {LDA};
   }

   //generic_: cross c1, c2, c3;
  
endgroup

cpa cov = new();
  // Apply Stimulus
  initial
    begin
      @(posedge clk)
      { opcode, data, accum } = 19'h0_37_DA; @(posedge clk) checkit('h0_da);
      { opcode, data, accum } = 19'h0_37_37; @(posedge clk) checkit('h0_37);
      { opcode, data, accum } = 19'h1_37_DA; @(posedge clk) checkit('h0_da);
      { opcode, data, accum } = 19'h1_37_37; @(posedge clk) checkit('h0_37);
      { opcode, data, accum } = 19'h2_37_DA; @(posedge clk) checkit('h0_11);
      { opcode, data, accum } = 19'h2_DA_DA; @(posedge clk) checkit('h0_B4);
      { opcode, data, accum } = 19'h2_DA_72; @(posedge clk) checkit('h0_4C);
      { opcode, data, accum } = 19'h3_37_DA; @(posedge clk) checkit('h0_12);
      { opcode, data, accum } = 19'h3_DA_37; @(posedge clk) checkit('h0_12);
      { opcode, data, accum } = 19'h3_DA_DA; @(posedge clk) checkit('h0_DA);
      { opcode, data, accum } = 19'h4_37_DA; @(posedge clk) checkit('h0_ed);
      { opcode, data, accum } = 19'h4_DA_DA; @(posedge clk) checkit('h0_00);
      { opcode, data, accum } = 19'h4_DA_37; @(posedge clk) checkit('h0_ed);
      { opcode, data, accum } = 19'h5_37_DA; @(posedge clk) checkit('h0_37);
      { opcode, data, accum } = 19'h5_DA_DA; @(posedge clk) checkit('h0_DA);
      { opcode, data, accum } = 19'h6_37_DA; @(posedge clk) checkit('h0_da);
      { opcode, data, accum } = 19'h6_10_DA; @(posedge clk) checkit('h0_da);
      { opcode, data, accum } = 19'h7_37_00; @(posedge clk) checkit('h1_00);
      { opcode, data, accum } = 19'h2_07_12; @(posedge clk) checkit('h0_19);
      { opcode, data, accum } = 19'h3_1F_35; @(posedge clk) checkit('h0_15);
      { opcode, data, accum } = 19'h4_1E_1D; @(posedge clk) checkit('h0_03);
      { opcode, data, accum } = 19'h5_72_00; @(posedge clk) checkit('h1_72);
      { opcode, data, accum } = 19'h6_00_10; @(posedge clk) checkit('h0_10);
      { opcode, data, accum } = 19'h7_00_DA; @(posedge clk) checkit('h0_DA);
      $display ( "ALU TEST PASSED" );
      $finish;
    end

  initial
    begin
      $timeformat ( -9, 1, " ns", 9 );
      // SystemVerilog: enhanced literal notation
      #2000ns 
         $display ( "ALU TEST TIMEOUT" );
      $finish;
    end
endmodule
