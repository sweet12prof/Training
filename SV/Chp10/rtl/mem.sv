///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : mem.sv
// Title       : Memory Module
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Defines the memory module
// Notes       :
// Synchronous 8x32 Memory Design
// Specification:
//  Memory is 8-bits wide and address range is 0 to 31.
//  Memory access is synchronous.
//  Write data into the memory on posedge of clk when write=1
//  Place memory[addr] onto data bus on posedge of clk when read=1
//  The read and write signals should not be simultaneously high.
// 
///////////////////////////////////////////////////////////////////////////

module mem (
  //input        clk,
	// input        read,
	// input        write, 
	// input  logic [4:0] addr  ,
	// input  logic [7:0] data_in  ,
  // output logic [7:0] data_out
  mem_ifa2 MEM_TEST_BUS
);
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;

// SYSTEMVERILOG: logic data type
logic [7:0] memory [0:31] ;
  
  always @(posedge MEM_TEST_BUS.clk)
    if (MEM_TEST_BUS.write && !MEM_TEST_BUS.read)
// SYSTEMVERILOG: time literals
      #1 memory[MEM_TEST_BUS.addr] <= MEM_TEST_BUS.data_in;

// SYSTEMVERILOG: always_ff and iff event control
  always_ff @(posedge MEM_TEST_BUS.clk iff ((MEM_TEST_BUS.read == '1)&&(MEM_TEST_BUS.write == '0)) )
       MEM_TEST_BUS.data_out <= memory[MEM_TEST_BUS.addr];

endmodule
