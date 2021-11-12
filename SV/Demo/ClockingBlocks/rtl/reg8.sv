module reg8(
   inter ifa
);

always_ff @( posedge ifa.clk ) 
    begin : sync_proc
        ifa.Q <= ifa.D;
    end
endmodule