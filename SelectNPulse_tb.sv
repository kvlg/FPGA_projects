`include "SelectNPulse.sv"
 module SelectNPulse_tb ();
 timeunit 1ns;
 timeprecision 1ns;
 localparam N = 10;
 var bit Clock = 0;
 var logic Out;

 SelectNPulse #(.N(N))
           S1  (.Clock, .Pulse(Out));

 initial
    repeat (50) #10ns Clock = ~Clock;

endmodule: SelectNPulse_tb
