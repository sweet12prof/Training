module top(
    input logic       clk, 
                      rst, 
    input logic [7:0] Input, 
    output logic Out
);
    logic [7:0] Count_Out;
    inter ifa_top(clk, rst);
    
    Datapath DP (
                .Input,
                .Count_Out,
                .ifa(ifa_top.DP_CU)
            );

    Control CU(
                .ifa(ifa_top.CU_DP)
    );

    assign out = (Count_Out == 8'd4) ? 1'b1 : 1'b0;
endmodule