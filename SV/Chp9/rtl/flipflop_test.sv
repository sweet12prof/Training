///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : flipflop_test.sv
// Title       : Flipflop Testbench Module
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Defines the Flipflop testbench module
// Notes       :
// 
///////////////////////////////////////////////////////////////////////////

module testflop ();
timeunit 1ns;
timeprecision 100ps;

logic reset;
logic [7:0] qin,qout, qoutsamp;

// ---- clock generator code begin------
`define PERIOD 10
logic clk = 1'b0;

always
    #(`PERIOD/2)clk = ~clk;

// ---- clock generator code end------


flipflop DUV(.*);

//<add clocking block>
    default clocking cb @ (posedge clk);
        default input #1step output #4;

        input qout;
        output reset, qin;
    
    endclocking
    assign qoutsamp = cb.qout;
//<add stimulus to drive clocking block>
    initial  
        begin 
           // fork 
                @(cb)
                    cb.reset <= 1'b1;
                ##3 cb.reset <= 1'b0;
           // join
            //    @(cb);
           // fork
                for(int i=0; i<128; i++)
                    begin 
                        @cb;
                            cb.qin <= i;
                       // @(cb.qout); 
                            
                        
                    end                  
            ##2;
            $finish();
          
        end

        
endmodule
