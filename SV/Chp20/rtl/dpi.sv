
module dpi;
`define M_PI_4		0.78539816339744830962	/* pi/4 */
 import "DPI-C"  system = function    int sv_system (string command);
 import "DPI-C"  getenv = function string sv_getenv(string name);
 import "DPI-C"  sin       = function real sv_sin (real x); 
 real someVal, res;

initial 
    begin
       sv_system("echo 'Hello World'");
       sv_system("date");
       $display(sv_getenv("PATH"));

        someVal = `M_PI_4;

        for (int i=0; i <8; i++)
            begin
                res = sv_sin(someVal * i);
                $display("The %d value is %f", i, res) ;
            end 
    end
endmodule