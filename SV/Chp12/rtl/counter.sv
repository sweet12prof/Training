///////////////////////////////////////////////////////////////////////////
// (c) Copyright 2013 Cadence Design Systems, Inc. All Rights Reserved.
//
// File name   : counter.sv
// Title       : Simple class
// Project     : SystemVerilog Training
// Created     : 2013-4-8
// Description : Simple counter class
// Notes       :
// 
///////////////////////////////////////////////////////////////////////////

module counterclass ;
    import classdefs::*; 
    import timer::*;

    timeunit 1ns;
    timeprecision 100ps;

    counter bPtr;
    upCounter upCtrPtr = new(12, 1, 8);
   // upCounter upCtrPtr2;
    
    initial begin
            bPtr = upCtrPtr;
            //upCtrPtr2 = bPtr;
            //$cast(upCtrPtr2, bPtr);
            fork
                begin
                    repeat(30)
                        begin
                            bPtr.next(); 
                            //upCtrPtr2.next();
                        end  
                end
            join
    end

    

    // initial 
    // begin
    //     fork
    //         begin
    //             repeat(30)
    //                 begin
    //                     bPtr.next(); 
    //                 end  
    //         end 
    //     join    
    // end
endmodule
