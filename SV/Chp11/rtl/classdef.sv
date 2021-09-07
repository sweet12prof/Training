package classdefs;
    class counter;
        protected int count,
                      max,
                      min;
        extern function void load(input int count);
        extern function int getCount();
        extern function new(input int count, input int max, input int min);
        extern function void check_limit(input int arg1, input int arg2);
        extern function void check_set(input int set);
    endclass

    class upCounter extends counter;
        protected bit carry; 
        local static int counterNum;
        extern function new(input int count,  input int max, input int min);
        extern function void next();
        extern static function  int getCounterNum();
        extern function bit getCarry();
        extern function void setCarry(input bit carry);
    endclass


    class downCounter extends counter;
        protected bit borrow;
        local static int counterNum;
        extern function new(input int count,  input int max, input int min);
        extern function void next();
        extern static function  int getCounterNum();
    endclass: downCounter //downCounter extends counter
    


// ------Functions Definitions Base Class ---------//
    function void counter::load(input int count);
        // this.count = count;
        counter::check_set(count);
    endfunction : load

    function int counter::getCount();
        return this.count;
    endfunction
    
    function counter::new(input int count, input int max, input int min);
        //this.count = count;
        counter::check_limit(max, min);
        counter::check_set(count); 
    endfunction

    function void counter::check_limit(input int arg1,  input int arg2);
        if(arg1 < arg2)
            begin
                this.min = arg1; 
                this.max = arg2;
            end
        else 
            begin 
                this.min = arg2;
                this.max = arg1;
            end
    endfunction:check_limit

    function void counter::check_set(input int set);
        if(set <= this.max && set >= this.min )
            begin 
                this.count = set;
            end
        else 
            begin 
                $display("The value of set is greater or lesser than max: %3.0d and min: %3.0d", 
                this.max, this.min);
                this.count = this.min;
            end 
    endfunction: check_set

    
//--------------------------------------------------//



//--------Functions UpCounter Derive Class----------//
    function upCounter::new(input int count, input int max, input int min);
        super.new(count, max, min);
        this.carry = 1'b0;
        this.counterNum = this.counterNum + 1;
    endfunction: new 

    function void upCounter::next();
        //this.count = this.count + 1;
        if(this.count < this.max && this.count >= this.min)
            begin           
                this.count = this.count + 1;
                this.carry = 0;
            end              
        else  
            begin 
                this.count = this.min;
                this.carry = 1'b1;
            end   
        $display("Current Value of UpCount is: %3.0d", this.count);
    endfunction: next

    function  int upCounter::getCounterNum();
        return upCounter::counterNum;
    endfunction

    function  bit upCounter::getCarry();
        return upCounter::carry;
    endfunction

    function void upCounter::setCarry(input bit carry);
        this.carry = carry;
    endfunction
    
//--------------------------------------------------//



//-------------Function Defuinitions DownCounter-----//
    function downCounter::new(input int count,  input int max,  input int min);
        super.new(count, max, min);
        this.borrow = 1'b0;
        this.counterNum = this.counterNum + 1;
    endfunction: new

    function void downCounter::next();
        if(this.count <= this.max && this.count >= this.min) 
            begin           
                this.count = this.count - 1;
                this.borrow = 1'b0;                
            end
        else 
            begin 
                this.count = this.max;
                this.borrow = 1'b1;
            end
        $display("Current Value of DownCount is:%3.0d", this.count);
    endfunction: next
    
    function  int downCounter::getCounterNum();
        return downCounter::counterNum;
    endfunction 
//-------------------------------------------------- //
endpackage