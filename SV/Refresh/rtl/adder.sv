timeunit 1ns;
timeprecision 100ps;
module adder8 (
    input logic [7:0] A, B, 
    output logic [7:0] Sum
);
    always_comb 
    begin : adder_proc
        Sum = A + B;
    end
endmodule