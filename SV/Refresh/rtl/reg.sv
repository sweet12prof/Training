module reg8(
    input logic clk,
                clr, 
                load,
    input logic[7:0] D, 
    output logic [7:0] Q  
); 

    always_ff @( posedge clk,  posedge clr) 
    begin : flop_proc
        if(clr == 1'b1)
            Q <= '0;
        else 
            if(load)
                Q <= D;
    end
endmodule
