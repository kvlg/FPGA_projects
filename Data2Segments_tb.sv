`include "General1.sv" 
`include "Data2Segments.sv"

module Data2Segments_tb ();
 timeunit 1ns;
 timeprecision 1ns;

 localparam Size   = 4,
            Signed = "Yes",
            ISize = (Signed == "No") ?
            General1::clog10(1<<Size) :
            General1::clog10(1<<(Size-1)) + 1,
            ClockPeriod_ns = 20,
            RefreshTime_ns = 3*ISize*ClockPeriod_ns;

 var bit Clock;
 var bit [ Size-1:0] Data;
 var bit [ISize-1:0] Indicators;
 var bit [ 7:0] Segments;

 Data2Segments #(.ClockPeriod_ns(ClockPeriod_ns),
                 .Size(Size),
                 .Signed(Signed),
                 .RefreshTime_ns(RefreshTime_ns))
       Decoder1 (.Clock, .Data, .Indicators, .Segments);

 var int HalfClockPeriod_ns = ClockPeriod_ns / 2;
 var int Repeats = 2**Size * RefreshTime_ns / HalfClockPeriod_ns;

            initial #10ns
               repeat (Repeats) #(HalfClockPeriod_ns) Clock = ~Clock;        
            initial
               begin: testbench
             static int Min = (Signed == "No") ? 0 : -2**(Size-1)+1;
             static int Max = (Signed == "No") ? 2**(Size)-1 : 2**(Size-1)-1;
             for (int i = Min; i <= Max; i++)
               begin
                 Data = i; #(RefreshTime_ns);
               end
            end: testbench
 endmodule: Data2Segments_tb
