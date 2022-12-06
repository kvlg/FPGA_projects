`include "DataGenerator.sv" 
module DataGenerator_tb ();
 timeunit 1ns;
 timeprecision 1ns;
 parameter Size               = 3,
           Signed             = "Yes",
           ClockPeriod_ns     = 20,
           FilterPeriod_ns    = 100,
           PauseInterval_ns   = 2500,
           RepeatsInterval_ns = 1500;
 var bit Clock = 0;
 var logic Button_Up = 1;
 var logic Button_Reset = 1, Button_Down = 1;
 var logic [Size-1:0] Data;

DataGenerator #(.Size(Size),
                .Signed(Signed),
                .ClockPeriod_ns(ClockPeriod_ns),
                .FilterPeriod_ns(FilterPeriod_ns),
                .PauseInterval_ns(PauseInterval_ns),
                .RepeatsInterval_ns(RepeatsInterval_ns))
          DG1  (.Clock,
                .Button_Up,
                .Button_Reset,
                .Button_Down,
                .Data);

initial
 repeat (4700) #(ClockPeriod_ns/2) Clock = ~Clock;
initial begin: testbench
 #1000 Button_Up   = 0; #13_000 Button_Up   = 1;
 #1000 Button_Down = 0; #13_000 Button_Down = 1;

 #1000 Button_Up   = 0; #1000 Button_Up   = 1;
 #2000 Button_Down = 0; #1000 Button_Down = 1;

 #1000 Button_Up   = 0; #5000 Button_Reset = 0;
 #100 Button_Reset = 1; #5000 Button_Up    = 1;
 end: testbench

endmodule: DataGenerator_tb

