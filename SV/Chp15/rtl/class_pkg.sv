package class_defs; 
   
    class randProps; 
        
        randc bit [4:0] addr; 
        rand bit [7:0] data;

        extern function new(
                             input bit [4:0] addr, 
                             input bit [7:0] data
                            );    
        constraint c1 {
                        data dist {[8'h41:8'h5a]:=80, [8'h61:8'h7a]:=20}; 
                    }


    covergroup cpa; 
        c1: coverpoint addr;
        c2: coverpoint data{
            bins upCase    = {[8'h41 : 8'h5a]}; 
            bins lowCase   = {[8'h61 : 8'h7a]};
            bins defrest = default;
        }
    endgroup
    
    endclass

        function randProps::new(input bit [4:0] addr, input bit [7:0] data); 
            this.addr = addr;
            this.data = data;
            cpa = new(); 
        endfunction

         
endpackage