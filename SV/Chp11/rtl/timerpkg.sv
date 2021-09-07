package timer;
    import classdefs::*;
    
    class timer_;
        upCounter hours;
        upCounter minutes; 
        upCounter seconds;
        extern function new(int hour, int minute, int second);
        extern function void load(int hour, int minute, int second);
        extern function void showVal();
        extern function void next();
    endclass

    function timer_::new(int hour, int minute, int second);
        hours   = new(hour, 0, 23);
        minutes = new(minute, 0, 59);
        seconds = new(second, 0, 59);
    endfunction : new

    function void timer_::load(int hour, int minute, int second);
        this.hours.load(hour);
        this.minutes.load(minute);
        this.seconds.load(second);
    endfunction : load

    function void timer_::showVal();
        $display("Time is %d : %d : %d", this.hours.getCount(), 
        this.minutes.getCount(), this.seconds.getCount());
    endfunction : showVal

    function void timer_::next();
        this.seconds.next();
        if(this.seconds.getCarry())
            begin 
                this.minutes.next();
                this.seconds.setCarry(1'b0);
            end
        if(this.minutes.getCarry())
            begin 
                this.hours.next();
                this.minutes.setCarry(1'b0);
            end
    endfunction: next
    export classdefs::*;
endpackage
