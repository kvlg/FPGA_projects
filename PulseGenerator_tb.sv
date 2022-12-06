`include "PulseGenerator.sv"
 module PulseGenerator_tb ();
 timeunit 1ns;
 timeprecision 1ns;
 var bit Clock = 0;
 var logic Button_Up = 1, Button_Down = 1;
 var logic Up, Down;

 PulseGenerator #(.ClockPeriod_ns(20),
                  .PauseInterval_ns(25_000),
                  .RepeatsInterval_ns(15_000))
             PG1 (.Clock, .iUp(Button_Up), .iDown(Button_Down), .oUp(Up), .oDown(Down));

 initial
  repeat (30_000) #10 Clock = ~Clock;
 initial
  begin: testbench
   #(50_500) Button_Up = 0;
   #(75_000) Button_Up = 1;
   #(50_000) Button_Down = 0;
   #(20_000) Button_Down = 1;
   #(10_000) Button_Down = 0; Button_Up = 0;
  end: testbench
 endmodule: PulseGenerator_tb

