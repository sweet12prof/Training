interface mem_ifa2( input clk);
    
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

    default clocking cb @(posedge clk);
        default output negedge;
        default input #0;
        input data_out;
        output read, write, addr, data_in;
    endclocking


     task automatic write_mem(
        const ref logic [7:0] data_in_arg, 
        const ref logic [4:0] addr_arg, 
        ref logic [4:0] addr, 
        ref logic [7:0] data_in, 
        ref read, write,
        input logic debug = 1'b0
    );

    @ (cb)
    cb.addr    <= addr_arg;
    cb.data_in <= data_in_arg;
    cb.read    <= 1'b0;
    cb.write   <= 1'b1;
    //##1;
    @(cb);
    cb.read    <= 1'b1;
    cb.write   <= 1'b0;
    if(debug)
        $display("Write_Address: %d \t Data_Value: %c", cb.addr, cb.data_in);
    else 
        $write("");
        //end
    //  ##3;   
    endtask : write_mem  //automatic


    task automatic read_mem(
        const ref logic [4:0] addr_arg, 
        ref logic [4:0] addr, 
        ref logic [7:0] data_out_arg, 
        const ref logic [7:0] data_out, 
        ref logic read, write,
        input logic debug = 1'b0
    );
       // @(cb)
        cb.addr  <= addr_arg;
        cb.read  <= 1'b1; 
        cb.write <= 1'b0;
        @(cb)
         data_out_arg = cb.data_out;
        
        // @(cb); @(cb);
           if(debug)
                $display("Read_Address: %d \t Data_Value: %c", cb.addr, cb.data_out);
           else 
                $write("");
        // ##4;
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


    // task automatic genRand(
    //     output a;
    //     output d;
    // );
        
  //  endtask //automatic
endinterface //mem_ifa2
