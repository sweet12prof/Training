timeunit 1ns;
timeprecision 100ps;

module Datapath (
    input logic [7:0]  Input,
    output logic [7:0] Count_Out,
    inter ifa
);
    logic [7:0] adderOut, 
                shift_Out;
    
    logic count_clr;

    assign count_clr = ifa.rst | ifa.flop_rst;

    reg8 Count(
        .clk(ifa.clk), 
        .clr(count_clr), 
        .load(ifa.count_Load), 
        .D(adderOut),
        .Q(Count_Out)
    );

    shifter SHIFT_REG(
        .clk(ifa.clk), 
        .Shift_En(ifa.shift_En),
        .shift_rst(count_clr),
        .Load_En(ifa.Load_En), 
        .D(Input), 
        .Q(shift_Out)
    );

    comparator COMP(
         .A(shift_Out), 
         .Aeq10(ifa.Aeq10) 
    );

    adder8 ADD(
         .A(Count_Out), 
         .B('b1), 
         .Sum(adderOut)
    );

    flop SHIFT_OUT (
                     .clk(ifa.clk), 
                     .rst(ifa.flop_rst), 
                     .D(shift_Out[0]), 
                     .en(ifa.shift_En), 
                     .Q(ifa.n_0)
    );

    
    
endmodule