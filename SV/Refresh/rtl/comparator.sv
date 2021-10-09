module comparator(
    input logic [7:0] A, 
    output logic Aeq10 
);
    always_comb begin : blockName
        unique if(A == '0)
            Aeq10 = 1'b1; 
        else 
            Aeq10 = 1'b0;
    end
endmodule