module mem_test_2(
    mem_ifa2 ifa
);
timeunit 1ns;
timeprecision 1ns;

   import class_defs::*;
// SYSTEMVERILOG: new data types - bit ,logic
bit         debug = 1;
logic [7:0] var_d_in;      // stores data read from memory for checking
int status;
logic [4:0] addr_var;
logic [7:0] data_in_var; 
int j;
// assign var_d_in = ifa.data_out; 

randProps class_Rand_gen = new(0, 0, ifa);




// Monitor Results
  initial begin
      $timeformat ( -9, 0, " ns", 9 );
// SYSTEMVERILOG: Time Literals
      #40000ns $display ( "MEMORY TEST TIMEOUT" );
      $finish;
    end


// Without constraints

initial begin
    $display("Clear Memory Test");
      $display("");
      $display("------With Constraints-------");
      class_Rand_gen.constraint_mode(1);

    for (int i = 0; i< 32; i++)
     // Write data = address to every address location
        begin 
             j = class_Rand_gen.randomize();
            data_in_var =  class_Rand_gen.data;
            addr_var = class_Rand_gen.addr;
                class_Rand_gen.write_mem(
                                .data_in_arg(data_in_var), 
                                .addr_arg(addr_var), 
                                .debug(1'b1)
            );

             //@ (negedge ifa.clk);
             class_Rand_gen.read_mem(
                    .addr_arg(addr_var), 
                    .data_out(var_d_in), 
                    .debug(1'b1)
                );
                if(var_d_in != data_in_var)
                    begin
                        status++;
                        $display("Value at Mem_%d is incorrect. Expected: %d, Got: %d", ifa.addr, data_in_var, var_d_in);
                    end
        end

      $display("");
end

endmodule