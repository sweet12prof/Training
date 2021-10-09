package typedefs;
    typedef enum logic [2:0] { 
        Input = 3'b000, 
        Idle = 3'b001, 
        Inc   = 3'b010, 
        shift = 3'b011, 
        Output= 3'b100
    } state_t;
endpackage