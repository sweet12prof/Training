///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : mem_test.sv
// Title       : Memory Testbench Module
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Defines the Memory testbench module
// Notes       :
// 
///////////////////////////////////////////////////////////////////////////

module mem_test import routines::*; ( //input logic clk, 
                  // output logic read, 
                  // output logic write, 
                  // output logic [4:0] addr, 
                  // output logic [7:0] data_in,     // data TO memory
                  // input  wire [7:0] data_out     // data FROM memory
                  mem_ifa   TEST_MEM_BUS
                );
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;

// SYSTEMVERILOG: new data types - bit ,logic
bit         debug = 1;
logic [7:0] d_out, var_d_in;      // stores data read from memory for checking
int status;

assign var_d_in = TEST_MEM_BUS.data_out; 

// Monitor Results
  initial begin
      $timeformat ( -9, 0, " ns", 9 );
// SYSTEMVERILOG: Time Literals
      #40000ns $display ( "MEMORY TEST TIMEOUT" );
      $finish;
    end

initial
  begin: memtest
  int error_status;

    $display("Clear Memory Test");

    for (int i = 0; i< 32; i++)
       // Write zero data to every address location
       begin
          @ (negedge TEST_MEM_BUS.clk) TEST_MEM_BUS.write_mem(                           
                              .data_in_arg(8'h00), 
                              .addr_arg(i), 
                              .addr(TEST_MEM_BUS.addr), 
                              .data_in(TEST_MEM_BUS.data_in), 
                              .read(TEST_MEM_BUS.read), 
                              .write(TEST_MEM_BUS.write), 
                              .debug(1'b0)
                  );
       end

    for (int i = 0; i<32; i++)
      begin 
       // Read every address location
          @ (negedge TEST_MEM_BUS.clk) TEST_MEM_BUS.read_mem(
                    .addr_arg(i), 
                    .addr(TEST_MEM_BUS.addr), 
                    .data_out_arg(d_out), 
                    .data_out(var_d_in), 
                    .read(TEST_MEM_BUS.read), 
                    .write(TEST_MEM_BUS.write), 
                    .debug(1'b1)
                );
                
       // check each memory location for data = 'h00
          if(d_out != 'h00)
            begin
              status++;
              $display("Value at Mem_%d is incorrect. Expected: %d, Got: %d", i,i, d_out);
            end
      end

   // print results of test

     $display("Data = Address Test");

    for (int i = 0; i< 32; i++)
       // Write data = address to every address location
          @ (negedge TEST_MEM_BUS.clk) TEST_MEM_BUS.write_mem(                           
                            .data_in_arg(i), 
                            .addr_arg(i), 
                            .addr(TEST_MEM_BUS.addr), 
                            .data_in(TEST_MEM_BUS.data_in), 
                            .read(TEST_MEM_BUS.read), 
                            .write(TEST_MEM_BUS.write), 
                            .debug(1'b0)
                );
    for (int i = 0; i<32; i++)
      begin
       // Read every address location
                @ (negedge TEST_MEM_BUS.clk) TEST_MEM_BUS.read_mem(
                    .addr_arg(i), 
                    .addr(TEST_MEM_BUS.addr), 
                    .data_out_arg(d_out), 
                    .data_out(var_d_in), 
                    .read(TEST_MEM_BUS.read), 
                    .write(TEST_MEM_BUS.write), 
                    .debug(1'b1)
                );
       // check each memory location for data = address
          if(d_out != i)
                begin
                    status++;
                    $display("Value at Mem_%d is incorrect. Expected: %d, Got: %d", i,i, d_out);
                    
                end
      end

   //print results of test
   //void'(TEST_MEM_BUS.printstatus(status));
   TEST_MEM_BUS.printstatus(status);
    $finish;
  end

// add read_mem and write_mem tasks

// add result print function




endmodule
