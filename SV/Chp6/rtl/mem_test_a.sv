module mem_test_a import routines::*;(
    input  logic clk,
    output  logic [7:0] data_in,
    output logic read, write, 
    output logic [4:0] addr, 
    input logic [7:0] data_out
);
// SYSTEMVERILOG: timeunit and timeprecision specification
timeunit 1ns;
timeprecision 1ns;

logic [7:0] d_out, var_d_in;

    assign var_d_in = data_out; 
     
     initial begin
      $timeformat ( -9, 0, " ns", 9 );
        // SYSTEMVERILOG: Time Literals
      #40000ns $display ( "MEMORY TEST TIMEOUT" );
      $finish;
    end


    initial begin : clearing_and_check_mem
        
        for(int i=0; i<=31; i++)
            begin 
                @ (negedge clk) write_mem(                           
                                .data_in_arg(i), 
                                .addr_arg(i), 
                                .addr(addr), 
                                .data_in(data_in), 
                                .read(read), 
                                .write(write), 
                                .debug(1'b0)
                    );
            end
        
        for(int i=0; i<=31; i++)
            begin :read_for
                @ (negedge clk) read_mem(
                    .addr_arg(i), 
                    .addr(addr), 
                    .data_out_arg(d_out), 
                    .data_out(var_d_in), 
                    .read(read), 
                    .write(write), 
                    .debug(1'b1)
                );
                
                if(d_out != i)
                begin
                    $display("SIMULATION FAILED"); 
                    $display("Value at Mem_%d is incorrect. Expected: %d, Got: %d", i,i, d_out);
                    
                end
            end
        
    end

    
endmodule