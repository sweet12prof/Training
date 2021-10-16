timeunit 1ns;
timeprecision 100ps;

module Control(
    inter ifa,
    output logic done
); 
    import typedefs::*;
    
    state_t PS, NS;

    always_ff @(posedge ifa.clk, posedge ifa.rst ) 
    begin : PS_logic
        if(ifa.rst)
            PS <= Input;
        else 
            PS <= NS;
    end

    always_comb 
    begin : NS_logic
        case(PS)
            Input:
                NS = Idle; 
            Idle:
                 if(ifa.Aeq10 && !ifa.n_0)
                    NS = Output;
                else 
                    if(ifa.n_0)
                        NS = Inc;
                    else 
                        NS = shift;
            Inc:
                NS = shift;
            shift:
                NS = Idle; 
            Output:
                NS  = Input;
        endcase
    end


    always_comb 
    begin : outputLogic
        case(PS)
            Input: 
                begin
                    ifa.count_Load = 1'b0;
                    ifa.shift_En   = 1'b0;
                    ifa.Load_En    = 1'b1;
                    ifa.out_En     = 1'b0; 
                    ifa.flop_rst   = 1'b0;
                    done           = 1'b0;
                end
            
            Idle: 
                begin 
                    ifa.count_Load = 1'b0;
                    ifa.shift_En   = 1'b0;
                    ifa.Load_En    = 1'b0;
                    ifa.out_En     = 1'b0; 
                    ifa.flop_rst   = 1'b0;
                    done           = 1'b0;
                end

            Inc: 
                begin 
                    ifa.count_Load = 1'b1;
                    ifa.shift_En   = 1'b0;
                    ifa.Load_En    = 1'b0;
                    ifa.out_En     = 1'b0; 
                    ifa.flop_rst   = 1'b0;
                    done           = 1'b0;
                end 

            shift:
                begin 
                    ifa.count_Load = 1'b0;
                    ifa.shift_En   = 1'b1;
                    ifa.Load_En    = 1'b0;
                    ifa.out_En     = 1'b0;
                    ifa.flop_rst   = 1'b0; 
                    done           = 1'b0;
                end

            Output:
                begin
                    ifa.count_Load = 1'b0;
                    ifa.shift_En   = 1'b0;
                    ifa.Load_En    = 1'b0;
                    ifa.out_En     = 1'b1; 
                    ifa.flop_rst   = 1'b1;
                    done           = 1'b1;
                end
        endcase

    end
endmodule