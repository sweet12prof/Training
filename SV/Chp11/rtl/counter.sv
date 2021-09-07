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

    counter CNT1 = new(12, 0, 2);
    upCounter upCnt =  new(0, 15, 1);
    downCounter dwnCnt = new(20, 1, 50);

    // counter CNT2 = new(12, 0, 2);
    // upCounter upCnt2 =  new(0, 15, 1);
    // downCounter dwnCnt1 = new(20, 1, 50);
    // downCounter dwnCnt2 = new(20, 1, 50);
    timer_ clock = new(18, 59, 00);

// add counter class here    
    initial 
    begin
        fork
            begin
                $display("Count is %3.0d", CNT1.getCount());
                #5;
                CNT1.load(8);
                #5;
                $display("Count is %3.0d", CNT1.getCount());
                #5;
            end
        join
        $display("");
        fork
            begin
                 $display("Current Value of UpCounter : %3.0d", upCnt.getCount());
                 for(int i =0; i<50; i++)
                    begin 
                        upCnt.next();
                        #5;
                    end
            end
        join
        $display("");
        fork
            begin 
                repeat(70)
                    begin
                        clock.showVal();
                        #5; 
                        clock.next();
                        // #5;
                        // clock.showVal();
                    end
            end
        join
        
        // fork 
        //     fork
        //         begin
        //             $display("Current Value of DownCount is: %3.0d", dwnCnt.getCount());
        //             for(int i =0; i<30; i++)
        //                 begin 
        //                     dwnCnt.next();
        //                     #5;
        //                 end
        //         end
        //     join_any
        //     disable fork;
        //         repeat(70)
        //             begin
        //                 clock.showVal();
        //                 #5; 
        //                 clock.next();
        //                 #5;
        //                 clock.showVal();
        //             end
        // join


         

         $display("DownCounter Objects created: %3.0d", downCounter::getCounterNum());
         $display("UpCounter Objects created: %3.0d", upCounter::getCounterNum());
        $finish();

    end

endmodule
