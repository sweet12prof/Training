module Datapath (
    input logic [7:0]  Input,
    output logic [7:0] Count_Out,
    inter ifa
);
    logic [7:0] adderOut, 
                shift_Out;


    reg8 Count(
        .clk(ifa.clk), 
        .clr(ifa.rst), 
        .load(ifa.count_Load), 
        .D(adderOut),
        .Q(Count_Out)
    );

    shifter SHIFT_REG(
        .clk(ifa.clk), 
        .Shift_En(ifa.shift_En), 
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
    
endmodule