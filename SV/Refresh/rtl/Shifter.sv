timeunit 1ns;
timeprecision 100ps;

module shifter (
    input logic clk, 
                Shift_En, 
                Load_En,
                shift_rst, 
    input logic [7:0]  D, 
    output logic [7:0] Q
);
    always_ff @( posedge clk, posedge shift_rst ) 
    begin : Shifter_proc
        priority if(shift_rst) 
            Q <= '0;
        else if(Shift_En && !Load_En)
            Q <= Q >> 1;
        else if(!Shift_En && Load_En)
            Q <= D;
        else ;
    end
endmodule