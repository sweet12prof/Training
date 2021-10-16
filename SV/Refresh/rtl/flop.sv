module flop (
    input logic clk, rst, D, en, 
    output logic  Q 
);
    always_ff @( posedge clk, posedge rst ) begin : flop_D_Q
        if(rst)
            Q <= '0;
        else if(en)
            Q <= D;
    end
    
endmodule