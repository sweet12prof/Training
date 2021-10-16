timeunit 1ns;
timeprecision 100ps;

module top(
    input logic       clk, 
                      rst, 
    input logic [7:0] Input, 
    output logic Out, done
);
    logic [7:0] Count_Out;
    //logic done;
    inter ifa_top(clk, rst);
    
    Datapath DP (
                .Input,
                .Count_Out,
                .ifa(ifa_top.DP_CU)
            );

    Control CU(
                .ifa(ifa_top.CU_DP),
                .done
    );

    // assign Out = (Count_Out == 8'd4) ? 1'b1 : 1'b0;

    always_comb begin : out_logic
        if(done)
            if(Count_Out == 8'd4)
                Out = 1'b1;
            else 
                Out = 1'b0;
        else 
                Out = 1'b0;
    end
endmodule