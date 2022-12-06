`include "Filter.sv"
 module Filter_tb ();
 timeunit 1ns;
 timeprecision 1ns;
 localparam Size            = 2,
            ClockPeriod_ns  = 20,
            FilterPeriod_ns = 70_000;
 var bit Clock = 0;
 var logic [Size-1:0] Buttons = '1;
 var logic [Size-1:0] Outs;

Filter #(.Size(Size),
         .ClockPeriod_ns(ClockPeriod_ns),
         .FilterPeriod_ns(FilterPeriod_ns))
    F1  (.Clock, .I(Buttons), .O(Outs));

 initial
     repeat (64000) #10ns Clock = ~Clock;
 initial
     begin: testbench
     #140000ns Buttons = 'b01;
     #140000ns Buttons = 'b11;
     #75000ns  Buttons = 'b00;
     #140000ns Buttons = 'b10;
 end: testbench
 endmodule: Filter_tb

