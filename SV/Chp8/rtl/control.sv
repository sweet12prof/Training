timeunit 1ns;
timeprecision 100ps;
module control import typedefs::*;(
    output logic mem_rd, 
                 load_ir, 
                 halt, 
                 inc_pc, 
                 load_ac, 
                 load_pc, 
                 mem_wr,
    
    output state_t state,
    input opcode_t opcode, 
    input logic zero, 
                clk, 
                rst_ 
);

    state_t ps, ns;
    logic [6:0] controlOut;
    logic isHLT, isALUOP, sANDz, isJMP, isSTO;
    
    always_ff @( posedge clk, negedge rst_ ) begin : state_flops
        if(!rst_)
            ps <= INST_ADDR;
        else 
            ps <= ns;
    end

    always_comb begin : ns_compute
        case(ps)
            INST_ADDR: 
                begin
                    if(rst_)
                        begin 
                            controlOut = 7'b100_0000; 
                            ns = INST_FETCH; 
                        end
                    else 
                        begin
                            controlOut = 7'b0000_000;
                            ns = INST_ADDR; 
                        end  
                end 
            
            INST_FETCH:
                begin
                    controlOut = 7'b110_0000;
                    ns = INST_LOAD;
                end
            
            INST_LOAD:
                begin
                    controlOut = 7'b110_0000;
                    ns = IDLE;
                end 
            
            IDLE:
                begin
                    controlOut = {2'b00, isHLT, 4'b1000};
                    ns = OP_ADDR;
                end

            OP_ADDR:
                begin
                    controlOut = {isALUOP, 6'b000_000};
                    ns = OP_FETCH;
                end 
            
            OP_FETCH:
                begin
                    controlOut = {isALUOP, 2'b00, sANDz, isALUOP, isJMP, 1'b0};
                    ns = ALU_OP;
                end
            
            ALU_OP:
                begin
                    controlOut = {isALUOP, 2'b00, isJMP, isALUOP, isJMP, isSTO };
                    ns = STORE;
                end
            
            STORE: 
                begin
                    controlOut = 7'b000_0000; 
                    ns = INST_ADDR;
                end 

            default:
                begin
                    controlOut = 7'b000_0000;
                    ns = INST_ADDR;
                end 
        endcase
    end

    assign isHLT = (opcode == HLT) ? 1'b1 : 1'b0;
    
    always_comb begin : isALUOP_comp
        if(opcode inside {AND, ADD, XOR, LDA})
            isALUOP = 1'b1; 
        else 
            isALUOP = 1'b0;
    end

    always_comb begin : issandz
        if(opcode == SKZ && zero == 1'b1)
            sANDz = 1'b1; 
        else 
            sANDz = 1'b0;
    end

    assign isJMP = (opcode == JMP) ? 1'b1 : 1'b0;

    assign isSTO = (opcode == STO) ? 1'b1 : 1'b0;

    // assign mem_rd = controlOut[6];
    // assign load_ir  = controlOut[5];
    // assign halt     = controlOut[4];
    // assign inc_pc   = controlOut[3];
    // assign load_ac  = controlOut[2];
    // assign load_pc  = controlOut[1];
    // assign mem_wr   = controlOut[0];
    assign state = ps;
    always_ff @(posedge clk)
        begin : output_gate 
            
                
                    mem_rd  <= controlOut[6]; 
                    load_ir <= controlOut[5];
                    halt    <= controlOut[4]; 
                    inc_pc  <= controlOut[3]; 
                    load_ac <= controlOut[2]; 
                    load_pc <= controlOut[1]; 
                    mem_wr  <= controlOut[0];  
               
            
        end
endmodule