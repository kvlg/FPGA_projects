module lights
 (Clock,Reset,TPswitch,TL,TM,TR,PL,PR,Indicators,Segments,Beep,PWM);
 parameter ClockPeriod_ns = 20,
    TL_Green = 20, TL_Red = 22,
    TM_Green = 20, TM_Red = 44,
    TR_Green = 20, TR_Red = 44,
    PL_Green = 42, PL_Red = 46,
    PR_Green = 42, PR_Red = 46;
 localparam 
 TLSize  = ((TL_Green > TL_Red) ? TL_Green : TL_Red),
 TMSize  = ((TM_Green > TM_Red) ? TM_Green : TM_Red),
 TRSize  = ((TR_Green > TR_Red) ? TR_Green : TR_Red),
 PLSize  = ((PL_Green > PL_Red) ? PL_Green : PL_Red),
 PRSize  = ((PR_Green > PR_Red) ? PR_Green : PR_Red),
 TLMSize  = ((TLSize  > TMSize) ? TLSize   : TMSize),
 TSize = clog2((TLMSize > TRSize) ? TLMSize : TRSize),
 PSize = clog2((PLSize > PRSize) ? PLSize   : PRSize),
 Size = 16;
 input  bit   Clock;
 input  logic Reset, TPswitch;
 output logic [3:0] TL, TM, TR;
 output logic [1:0] PL, PR;
 output logic Beep=1, PWM;
 output logic [7:0] Indicators, Segments;
        logic B, Synch;
		  logic [Size-1:0] Data, Dest;
		  logic [TSize-1:0] TLsec, TMsec, TRsec;
        logic [PSize-1:0] PLsec, PRsec;
		  
		  always_ff @(posedge Clock)
		  if (TL[3] == 1) Dest <= 16'b0000100100000000;
		  else if (TL[3] == 0) Dest <= 16'b0001000000000000;

 lights_stm #(.ClockPeriod_ns(ClockPeriod_ns),
              .TL_Green(TL_Green),
              .TL_Red(TL_Red),
				  .TM_Green(TM_Green),
				  .TM_Red(TM_Red),
				  .TR_Green(TR_Green),
				  .TR_Red(TR_Red),
				  .PL_Green(PL_Green),
				  .PL_Red(PL_Red),
				  .PR_Green(PR_Green),
				  .PR_Red(PR_Red))
		  lsm1 (.Clock,
		        .Reset,
				  .TL,.TM,.TR,
				  .PL,.PR,
				  .TLsec,.TMsec,.TRsec,
				  .PLsec,.PRsec,.B);		  

 PWMGenerator #(.Size(Size)) pwmg1 (.Clock, .Data, .PWM, .Synch); 
  Seconds2EightIndicators #(.TSize(TSize),
                            .PSize(PSize),
									 .ClockPeriod_ns(ClockPeriod_ns),
									 .RefreshTime_ns(200_000))
						s2ei1    (.Clock,
						          .TPswitch,
									 .TLsec,.TMsec,.TRsec,
									 .PLsec,.PRsec,
									 .Indicators,.Segments); 
 slow_me_down #(.Size(Size)) smd1 (.Clock, .Dest, .Data);
						
/////////////////  General function  //////////////////
 function automatic int clog2 (input int n);
 if (n < 1) clog2 = 1;
 else for (clog2 = 0; n > 0; n >>= 1) clog2++;
 endfunction: clog2 

endmodule: lights
