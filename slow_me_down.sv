module slow_me_down (Clock, Dest, Data);
 parameter    Size = 16;
 input  bit   Clock;
 input  logic [Size-1:0] Dest;
 output logic [Size-1:0] Data;

 SelectNPulse #(.N(500_000)) S0 (.Clock, .Pulse(Enable));

 always @(posedge Enable)
 if (Dest == 16'b0000100100000000)
   if (Data > Dest) Data = Data - 1;
	else Data = Dest;
 else if (Dest == 16'b0001000000000000)
   if (Data < Dest) Data = Data + 1;
	else Data = Dest;
 else Data = 16'b0001000000000000;

endmodule : slow_me_down