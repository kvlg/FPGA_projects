`include "General1.sv" 
`include "DGandD2S.sv"
 module DGandD2S_tb ();
 timeunit 1ns;
 timeprecision 1ns;
 localparam Size               = 4,
            Signed             = "Yes",
            ClockPeriod_ns     = 20,
            FilterPeriod_ns    = 100,
            PauseInterval_ns   = 2500,
            RepeatsInterval_ns = 1500,
            RefreshTime_ns     = 1500,
       ISize = (Signed == "No") ? General1::clog10(1<<Size) : (General1::clog10(1<<(Size-1))+1);
 logic Clock = 0;
 logic Button_Up = 1, Button_Reset = 1, Button_Down = 1; 
 logic [ISize-1:0] Indicators;
 logic [ 7:0] Segments;

 DGandD2S #(.Size(Size),
            .Signed(Signed),
            .ClockPeriod_ns(ClockPeriod_ns),
            .FilterPeriod_ns(FilterPeriod_ns),
            .PauseInterval_ns(PauseInterval_ns),
            .RepeatsInterval_ns(RepeatsInterval_ns),
            .RefreshTime_ns(RefreshTime_ns))
 B1        (.Clock, .Button_Up, .Button_Reset, .Button_Down, .Indicators, .Segments);

 initial repeat (4700) #(ClockPeriod_ns/2) Clock = ~Clock;
 initial begin: testbench

 #1000 Button_Up   = 0; #13_000 Button_Up   = 1;
 #1000 Button_Down = 0; #13_000 Button_Down = 1;

 #1000 Button_Up   = 0; #1000 Button_Up   = 1;
 #2000 Button_Down = 0; #1000 Button_Down = 1;

 #1000 Button_Up   = 0; #5000 Button_Reset = 0;
 #100 Button_Reset = 1; #5000 Button_Up    = 1;
 end: testbench
 endmodule: DGandD2S_tb