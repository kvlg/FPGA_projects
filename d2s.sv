module d2s (Clock,data,y,st_literal,Indicators,Segments);
 parameter Size = 8,
 ClockPeriod_ns = 20,
 RefreshTime_ns = 1_000_000;

 input bit Clock;
 input logic y;
 input logic [3:0] data;
 input logic [7:0] st_literal;
 output logic [7:0] Indicators, Segments;
 logic [7:0] zero = 'b1100_0000, one = 'b1111_1001, empty = 'b1111_1111;

 localparam Prescale = RefreshTime_ns / ClockPeriod_ns / Size, ICounterSize = $clog2(Size);

 var bit [ICounterSize-1:0] ICounter = 0;
 var bit Enable;

SelectNPulse #(.N(Prescale)) S1 (.Clock, .Pulse(Enable));

always_ff @(posedge Clock)
 begin: counter
  if (Enable)
   if (ICounter == 0)
     ICounter <= Size - 1;
  else
   ICounter <= ICounter - 1;
  end: counter

always @(posedge Clock)
  begin: outputs
   Indicators = ~(1 << ICounter);
	if      ((ICounter == 7) && (~data[3]     )) Segments = zero;
	else if ((ICounter == 7) && ( data[3]     )) Segments = one;
	else if ((ICounter == 6) && (~data[2]     )) Segments = zero;
	else if ((ICounter == 6) && ( data[2]     )) Segments = one;
	else if ((ICounter == 5) && (~data[1]     )) Segments = zero;
	else if ((ICounter == 5) && ( data[1]     )) Segments = one;
	else if ((ICounter == 4) && (~data[0]     )) Segments = zero;
	else if ((ICounter == 4) && ( data[0]     )) Segments = one;
	else if ((ICounter == 3) || (ICounter == 1)) Segments = empty;
	else if  (ICounter == 2)                     Segments = st_literal;
	else if ((ICounter == 0) && ( y       == 0)) Segments = zero;
	else if ((ICounter == 0) && ( y       == 1)) Segments = one;
  end: outputs

endmodule : d2s