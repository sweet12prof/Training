    interface inter(
        input clk, rst
    );
        logic count_Load, 
              shift_En,
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
            output n_0, 
                   Aeq10
        ); 
            
        modport CU_DP (
            input n_0,
                  Aeq10,
                  clk, 
                  rst,
            output count_Load,
                   out_En,
                   shift_En,
                   Load_En
        );
        
    endinterface: inter //typedefs
