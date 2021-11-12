timeunit 1ns;
timeprecision 100ps;

module testbench ();
    
    import typedefs::*;

    logic  clk, rst, Out, done; 
    logic [7:0] Input;
    int a;

    
    top TEST_TOP(.*);

    initial begin
        fork
            clk = 1'b0;    
        join_none
        
        fork
            rst = 1'b1;    
            #22 rst = 1'b0;
        join
         $display("  i\tInput\t\tOut");
    end

    always begin
        #5 clk = ~clk;
    end


    default clocking cb @(posedge clk);
        default input #1step output negedge;
        input Out, done; 
        output Input;
    endclocking

    clocking cb2 @(negedge done); 
        default input #1step output negedge;
        input Out;
    endclocking



    covergroup cg;
        In_hi_lo : coverpoint Input{
            bins lo = {['0 : 8'd127]};
            bins hi = {[8'd128:$]};
        }
            all : coverpoint Input{
                bins all_[] = {[0:$]};
            }
    endgroup:cg

    
    cg c1 = new();
    always  
    begin
        process::self.srandom(20);
         @(cb);
        for(int i=1; i<51; i++)
            begin 
                 cb.Input <= rand_gen();
                 c1.sample();
                @(cb2);
                $display("%3.0d\t%b\t%b", i, cb.Input, cb2.Out);
            end
        $finish;
    end
endmodule