`include "DataCounter.sv" 
module DataCounter_tb ();
 timeunit 1ns;
 timeprecision 1ns;
 localparam Size  = 3, ClockPeriod = 20ns;
 bit Clock = 0;
 logic Up = 0, Reset = 1, Down = 0;
 logic [Size-1:0] Data;

 DataCounter #(.Size(Size), .Signed("Yes"))
             DCnt1
              (.Clock, .Up, .Reset, .Down, .Data);


 initial repeat (500) #(ClockPeriod/2) Clock = ~Clock;

 initial
 begin: reset_generator
 #3000ns Reset = 0; #(ClockPeriod); Reset = 1;
 end: reset_generator

 initial
 begin: testbench

 localparam PauseTime = 320ns, RepeatsTime = 140ns;
 #210ns Up = 1; #(ClockPeriod); Up = 0;
 for (int i = 0; i < 8; i++)

 begin: up_generator1
 if (i == 0) #(PauseTime);
 else #(RepeatsTime); Up = 1; #(ClockPeriod); Up = 0;
 end: up_generator1

 #350ns Down = 1; #(ClockPeriod); Down = 0;
 for (int i = 0; i < 8; i++)

 begin: down_generator
 if (i == 0) #(PauseTime);
 else #(RepeatsTime); Down = 1; #(ClockPeriod); Down = 0;
 end: down_generator

 #350ns Up = 1; #(ClockPeriod); Up = 0;
 for (int i = 0; i < 5; i++)

 begin: up_generator2
 if (i == 0) #(PauseTime);
 else #(RepeatsTime); Up = 1; #(ClockPeriod); Up = 0;
 end: up_generator2

 end: testbench
endmodule: DataCounter_tb
