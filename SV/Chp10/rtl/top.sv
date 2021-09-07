///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : top.sv
// Title       : top module for Memory labs 
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Defines the top module for memory labs
// Notes       :
// Memory Lab - top-level 
// A top-level module which instantiates the memory and mem_test modules
// 
///////////////////////////////////////////////////////////////////////////

module top;
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;

// SYSTEMVERILOG: logic and bit data types
bit         clk;
//mem_ifa3    busa(clk);
    mem_ifa2 busa(clk);
// wire       read;
// wire       write;
// wire [4:0] addr;

// wire [7:0] data_out;      // data_from_mem
// wire [7:0] data_in;       // data_to_mem
initial begin
    clk = 1'b0;
end

// SYSTEMVERILOG:: implicit .* port connections
mem_test_2 test ( .ifa(busa.test_to_mem));

// SYSTEMVERILOG:: implicit .name port connections
mem memory (  .MEM_TEST_BUS(busa.mem_to_test));

always #5 clk = ~clk;
endmodule
