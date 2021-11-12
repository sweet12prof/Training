module regTest;
    
    logic clk;
    inter ifa(clk);
    
    reg8 R8 (
                .ifa(ifa.reg8_)
            );
    

initial 
    begin
        clk = 1'b0; 
        // cb.ifa.D = 8'h01;
    end

    always  
    begin
        #5 clk = ~clk;    
    end

    always
        begin 
            //@(ifa.cb);
            int i=0;
           for(i=0; i<256; i = i +1)
                begin 
                    @(ifa.cb); // synchronize to next cb event
                        ifa.cb.D <= i; // Assigns i to D, based on CB spec
                    @(ifa.cb.Q);  // wait on output response 
                    $display("D is %d, Q is %d", ifa.cb.D, ifa.cb.Q);  
                end
            $finish;
        end
endmodule