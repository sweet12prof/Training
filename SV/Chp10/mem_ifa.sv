interface mem_ifa(input clk);
        timeunit 1ns;
    timeprecision 1ns;
    logic read, write; 
    logic [4:0] addr;
    logic [7:0] data_in, data_out;

    modport mem_to_test (
        input read, write, addr, data_in, clk,
        output data_out
    );

    modport test_to_mem(
        input data_out, clk,
        output read, write, addr, data_in,
        import read_mem, import write_mem, import printstatus
    );


        task automatic write_mem(
        input logic [7:0] data_in_arg, 
        input logic [4:0] addr_arg, 
        ref logic [4:0] addr, 
        ref logic [7:0] data_in, 
        ref read, write,
        input logic debug = 1'b0
    );


    addr = addr_arg;
    data_in = data_in_arg;
    read  = 1'b0;
    write = 1'b1;

    if(debug)
        $display("Write_Address: %d \t Data_Value: %d", addr, data_in);
    else 
        $write("");
        //end
        
    endtask : write_mem  //automatic


    task automatic read_mem(
        input logic [4:0] addr_arg, 
        ref logic [4:0] addr, 
        ref logic [7:0] data_out_arg, 
        const ref logic [7:0] data_out, 
        ref logic read, write,
        input logic debug = 1'b0
    );
        
        addr  = addr_arg;
        read  = 1'b1; 
        write = 1'b0;
         
          #7 data_out_arg = data_out;
        

           if(debug)
                $display("Read_Address: %d \t Data_Value: %d", addr, data_out_arg);
           else 
                $write("");

    endtask //automatic

    // void function automatic printstatus()

    function automatic void printstatus(
        input int status
    ) ;
        if(status == 0)
            $display("SIMULATION PASSED WITH %d ERRORS", status);
        else 
            $display("SIMULTAION FAILED WITH %d ERRORS", status);
        return;
    endfunction : printstatus


    // function automatic void generateRandom_write(
    //     output logic [7:0] data, 
    //     output logic [4:0] addr
    // ); 
    // endfunction

endinterface:mem_ifa