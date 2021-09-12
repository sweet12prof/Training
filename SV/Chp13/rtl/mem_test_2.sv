module mem_test_2(
    mem_ifa2 ifa
);
timeunit 1ns;
timeprecision 1ns;

   import class_defs::*;
// SYSTEMVERILOG: new data types - bit ,logic
bit         debug = 1;
logic [7:0] d_out, var_d_in;      // stores data read from memory for checking
int status;
logic [4:0] addr_var;
logic [7:0] data_in_var; 
int j;
assign var_d_in = ifa.data_out; 

randProps class_Rand_gen = new(0, 0);




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
    class_Rand_gen.constraint_mode(0);
    for (int i = 0; i< 32; i++)
     // Write data = address to every address location
        begin 
            j = class_Rand_gen.randomize();
            data_in_var =  class_Rand_gen.data;
            addr_var = class_Rand_gen.addr;
                ifa.write_mem(
                                .data_in_arg(data_in_var), 
                                .addr_arg(addr_var), 
                                .addr(ifa.addr), 
                                .data_in(ifa.data_out), 
                                .read(ifa.read), 
                                .write(ifa.write), 
                                .debug(1'b1)
            );

             //@ (negedge ifa.clk);
             ifa.read_mem(
                    .addr_arg(addr_var), 
                    .addr(ifa.addr), 
                    .data_out_arg(d_out), 
                    .data_out(var_d_in), 
                    .read(ifa.read), 
                    .write(ifa.write), 
                    .debug(1'b1)
                );
                if(d_out != data_in_var)
                    begin
                        status++;
                        $display("Value at Mem_%d is incorrect. Expected: %d, Got: %d", ifa.addr, data_in_var, d_out);
                    end
        end

      $display("");
      $display("------With Constraints-------");
      class_Rand_gen.constraint_mode(1);

    for (int i = 0; i< 32; i++)
     // Write data = address to every address location
        begin 
            j = class_Rand_gen.randomize();
            data_in_var =  class_Rand_gen.data;
            addr_var = class_Rand_gen.addr;
                ifa.write_mem(
                                .data_in_arg(data_in_var), 
                                .addr_arg(addr_var), 
                                .addr(ifa.addr), 
                                .data_in(ifa.data_out), 
                                .read(ifa.read), 
                                .write(ifa.write), 
                                .debug(1'b1)
            );

             //@ (negedge ifa.clk);
             ifa.read_mem(
                    .addr_arg(addr_var), 
                    .addr(ifa.addr), 
                    .data_out_arg(d_out), 
                    .data_out(var_d_in), 
                    .read(ifa.read), 
                    .write(ifa.write), 
                    .debug(1'b1)
                );
                if(d_out != data_in_var)
                    begin
                        status++;
                        $display("Value at Mem_%d is incorrect. Expected: %d, Got: %d", ifa.addr, data_in_var, d_out);
                    end
        end

      $display("");






    // process::self.srandom(3);
    // for (int f = 0; f<32; f++)
    //   begin 
    //          @ (negedge ifa.clk);
    //         j = class_Rand_gen.randomize();
    //         data_in_var =  class_Rand_gen.data;
    //         addr_var = class_Rand_gen.addr;

    //         ifa.read_mem(
    //                 .addr_arg(addr_var), 
    //                 .addr(ifa.addr), 
    //                 .data_out_arg(d_out), 
    //                 .data_out(var_d_in), 
    //                 .read(ifa.read), 
    //                 .write(ifa.write), 
    //                 .debug(1'b1)
    //             );
                
    //    // check each memory location for data = 'h00
    //       if(d_out != data_in_var)
    //         begin
    //           status++;
    //           $display("Value at Mem_%d is incorrect. Expected: %d, Got: %d", ifa.addr, data_in_var, d_out);
    //         end
    //   end

end
endmodule