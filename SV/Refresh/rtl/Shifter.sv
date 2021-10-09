module shifter (
    input logic clk, 
                Shift_En, 
                Load_En, 
    input logic [7:0]  D, 
    output logic [7:0] Q
);
    always_ff @( posedge clk ) 
    begin : Shifter_proc
        priority if(Shift_En && !Load_En)
            Q <= Q >> 1;
        else if(!Shift_En && Load_En)
            Q <= D;
        else ;
    end
endmodule