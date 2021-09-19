package class_defs; 
   
    class randProps; 
        
        randc bit [4:0] addr; 
        rand bit [7:0] data;
        virtual interface mem_ifa2 ifa;

        extern function new(
                             input bit [4:0] addr, 
                             input bit [7:0] data, 
                             virtual interface mem_ifa2 ifa
                            );    
        constraint c1 {
                        data dist {[8'h41:8'h5a]:=80, [8'h61:8'h7a]:=20}; 
                    }

        

        extern task write_mem(
            const ref logic [7:0] data_in_arg, 
            const ref logic [4:0] addr_arg, 
            input logic debug = 1'b0
        );

        extern task read_mem(
            const ref logic [4:0] addr_arg, 
            ref logic [7:0] data_out, 
            input logic debug = 1'b0
        );

  

    endclass

        function randProps::new(
            input bit [4:0] addr, 
            input bit [7:0] data, 
            virtual interface mem_ifa2 ifa
        ); 
            this.addr = addr;
            this.data = data;
            this.ifa = ifa;
        endfunction

         task automatic randProps::write_mem(
             const ref logic [7:0] data_in_arg, 
             const ref logic [4:0] addr_arg, 
             input logic debug = 1'b0
        );
            @(ifa.cb);
                ifa.cb.addr <= addr_arg; 
                ifa.cb.data_in <= data_in_arg;
                ifa.cb.read <= 1'b0;
                ifa.cb.write <= 1'b1;
           @(ifa.cb);
                ifa.cb.read  <= 1'b0;
                ifa.cb.write <= 1'b0;
                if(debug)
                    $display("Write_Address: %d \t Data_Value: %c", ifa.cb.addr, ifa.cb.data_in);
                else 
                    $write("");
         endtask

        task randProps::read_mem(
            const ref logic [4:0] addr_arg, 
            ref logic [7:0] data_out, 
            input logic debug = 1'b0
        );
          @(ifa.cb);
            ifa.cb.addr <= addr_arg;
            ifa.cb.read <= 1'b1;
            ifa.cb.write <= 1'b0;
          @(ifa.cb);
            ifa.cb.read <= 1'b0;
            ifa.cb.write <= 1'b0;
            data_out  = ifa.cb.data_out;

             if(debug)
                    $display("Read_Address: %d \t Data_Value: %c", ifa.cb.addr, data_out);
                else 
                    $write("");
              

        endtask
endpackage