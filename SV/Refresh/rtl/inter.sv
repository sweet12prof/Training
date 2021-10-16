timeunit 1ns;
timeprecision 100ps;
    
    interface inter(
        input clk, rst
    );
        logic count_Load, 
              shift_En,
              flop_rst,
              Load_En,
              out_En, 
              n_0, 
              Aeq10;

        modport DP_CU(
            input  count_Load, 
                   out_En,
                   shift_En, 
                   Load_En,
                   clk, 
                   rst,
                   flop_rst,
            output n_0, 
                   Aeq10
        ); 
            
        modport CU_DP (
            input n_0,
                  Aeq10,
                  clk, 
                  rst,
                  flop_rst,
            output count_Load,
                   out_En,
                   shift_En,
                   Load_En
        );

        // modport Map_func(
        //     import rand_gen
        // );

 

    endinterface: inter //typedefs
