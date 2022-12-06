`include "General1.sv" 
`include "DGandD2SandPWM.sv" 
`timescale 1ns/1ns 
module DGandD2SandPWM_tb ();
 localparam Size          = 4,
           ClockPeriod_ns = 20,
          FilterPeriod_ns = 100,
         PauseInterval_ns = 2500,
       RepeatsInterval_ns = 1500,
           RefreshTime_ns = 1500,
             PWMPeriod_ns = 850,
                  PWMType = "Back",
                   Signed = "No",
                    ISize = (Signed == "No") ?
                   General1::clog10(1<<Size) :
                  (General1::clog10(1<<(Size-1)) + 1);

 bit Clock = 0;
 logic Button_Up = 1, Button_Reset = 1, Button_Down = 1, SignSwitch = 1;
 logic [ISize-1:0] Indicators;
 logic [ 7:0] Segments;
 logic Synch, PWM;

 DGandD2SandPWM #(.Size(Size),
                  .ClockPeriod_ns(ClockPeriod_ns),
                  .FilterPeriod_ns(FilterPeriod_ns),
                  .PauseInterval_ns(PauseInterval_ns),
                  .RepeatsInterval_ns(RepeatsInterval_ns),
                  .RefreshTime_ns(RefreshTime_ns),
                  .PWMPeriod_ns(PWMPeriod_ns),
                  .PWMType(PWMType))
              B  (.Clock,
                  .Button_Up,
                  .Button_Reset,
                  .Button_Down,
                  .SignSwitch,
                  .Indicators,
                  .Segments,
                  .Synch,
                  .PWM);

 initial repeat (4700) #(ClockPeriod_ns/2) Clock = ~Clock;
 initial begin: testbench
 #1000 Button_Up    = 0; #13_000 Button_Up     = 1;
 #1000 Button_Down  = 0; #13_000 Button_Down   = 1;
 #1000 Button_Up    = 0; #1000   Button_Up     = 1;
 #2000 Button_Down  = 0; #1000   Button_Down   = 1;
 #1000 Button_Up    = 0; #5000   Button_Reset  = 0;
 #100  Button_Reset = 1; #5000   Button_Up     = 1;
 end: testbench 
endmodule: DGandD2SandPWM_tb
