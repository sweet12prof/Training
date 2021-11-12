interface inter(
    input clk
);
    logic [7:0] D;
    logic [7:0] Q;

    modport reg8_ (
        input clk, D, 
        output Q
    );
    
    //  modport test_reg8 (
    //     output clk, D, 
    //     input Q
    // );
    clocking cb @(posedge clk);
            default input #1step output negedge;
            input  Q;
            output D;
    endclocking

            clocking cb_out @(negedge clk);
                default input #1step;  
                input  Q;
                output D;
            endclocking
endinterface //inter