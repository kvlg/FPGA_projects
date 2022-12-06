module SelectNPulse (Clock,Pulse);
 
 parameter N = 10;
 input var bit Clock;
 output var logic Pulse;
 var logic [$clog2(N)-1:0] Counter = 0;

 always_ff @(posedge Clock)
  begin
   if
    (Pulse) Counter <= 0;
   else
     Counter <= Counter + 1;
  end

 assign Pulse = (Counter == N - 1);

endmodule: SelectNPulse

