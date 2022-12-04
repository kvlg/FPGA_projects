/*`include "General1.sv" 
`include "SelectNPulse.sv"*/

module Data2Segments (Clock,Data,Indicators,Segments);
 parameter Size = 4,
         Signed = "Yes",
			  Code = "Str",
 ClockPeriod_ns = 20,
 RefreshTime_ns = 200_000; // Frefresh = 50kHz
 
localparam ISize = (Signed == "No") ?
           General1::clog10(1<<Size) :
          (General1::clog10(1<<(Size-1)) + 1);

 input  var bit Clock;
 input  var logic [ Size-1:0] Data;
 output var logic [ISize-1:0] Indicators;
 output var logic [ 7:0] Segments;
 
        var logic [ Size-1:0] ActualData;

import General1::Bin2BCD;
import General1::BCD2ESC;
import General1::clog2;

 localparam BCDSize = 4*ISize;
 var bit [4*ISize-1:0] BCD;
 
 generate
 begin: binary_to_BCD
  if (Signed == "No")
   always_comb BCD = (BCDSize)'(Bin2BCD(Data,BCDSize));
  else
   always_comb BCD = {(Data[Size-1] == 1'b0) ?
                     General1::Empty :
                     General1::Minus, 
                    (BCDSize-4)'(Bin2BCD(Data[Size-2:0],BCDSize-4))};
 end: binary_to_BCD

begin: BCD_to_segments
 if (ISize > 1)
  begin: multiple_indicators
   localparam Prescale = RefreshTime_ns / ClockPeriod_ns / ISize, ICounterSize = clog2(ISize);

 var bit [ICounterSize-1:0] ICounter = 0;
 var bit Enable;

SelectNPulse #(.N(Prescale)) S1 (.Clock, .Pulse(Enable));

always_ff @(posedge Clock)
 begin: counter
  if (Enable)
   if (ICounter == 0)
     ICounter <= ISize - 1;
  else
   ICounter <= ICounter - 1;
  end: counter

  always_comb
  begin: outputs
   Indicators = ~(1 << ICounter);
   Segments   = BCD2ESC(BCD[4*ICounter +: 4]);
  end: outputs
 
 end: multiple_indicators

 else always_comb begin: single_indicator
 Indicators = 1'b0; Segments   = BCD2ESC(BCD);

 end: single_indicator
 end: BCD_to_segments

 endgenerate

endmodule: Data2Segments