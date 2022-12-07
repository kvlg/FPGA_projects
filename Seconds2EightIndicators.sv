module Seconds2EightIndicators
 #(parameter TSize = 4,
             PSize = 4,
				 ClockPeriod_ns = 20,
				 RefreshTime_ns = 200_000) // 5kHz
 (input bit   Clock,
  input logic TPswitch,
  input logic [TSize-1:0] TLsec, TMsec, TRsec,
  input logic [PSize-1:0] PLsec, PRsec,
  output logic [7:0] Indicators,
  output logic [7:0] Segments);
/****************************************************
  *  Binary traffic and pedestrian seconds to BDC   *
  *                     Traffic                     *
  *   Tr Left    void     Tr Mid     void  Tr Right *
  *[31:28,27:24][23:20][19:16,15:12][11:8][7:4,3:0] *
  *	                Pedestrian                    *
  *   Ped Left       void      Ped Right     void   *
  * [31:28,27:24][23:20,19:16][15:12,11:8][7:4,3:0] *
  ***************************************************/
  logic [31:0] BCD;
  localparam NULL = 4'b1111;

  always_comb
  case (TPswitch)
    0 : BCD = {Bin2BCD(TLsec), NULL, Bin2BCD(TMsec), NULL, Bin2BCD(TRsec)};
    1 : BCD = {Bin2BCD(PLsec), NULL, NULL, Bin2BCD(PRsec), NULL, NULL};
  endcase
  /* ============== Indicators Cycle ============= */
  logic [2:0] ICounter = 0, Enable;
  always_ff @(posedge Clock)
  if (Enable) ICounter = ICounter + 1;
  always_comb
  begin: outputs
  Indicators = ~(1 << ICounter);
  Segments   = BCD2ESC(BCD[4*ICounter +: 4]);
  end: outputs
  /* ============= Frequency Divider ============= */
  localparam MaxPeriod = RefreshTime_ns/ClockPeriod_ns/8;
  logic [clog2(MaxPeriod)-1:0] DCounter = 0;
  assign Enable = (DCounter == 0);
  always_ff @(posedge Clock)
  if (Enable) DCounter <= MaxPeriod - 1;
  else DCounter <= DCounter - 1;  
////////////////////////////////////////////////////////
 function automatic [7:0] BCD2ESC (bit [3:0] x);
  case (x)
   0 : BCD2ESC = 'b1100_0000; 1 : BCD2ESC = 'b1111_1001;
   2 : BCD2ESC = 'b1010_0100; 3 : BCD2ESC = 'b1011_0000;
   4 : BCD2ESC = 'b1001_1001; 5 : BCD2ESC = 'b1001_0010;
   6 : BCD2ESC = 'b1000_0010; 7 : BCD2ESC = 'b1111_1000;
   8 : BCD2ESC = 'b1000_0000; 9 : BCD2ESC = 'b1001_0000;
   default: BCD2ESC = 'b1111_1111;
  endcase
 endfunction: BCD2ESC 

 function automatic [7:0] Bin2BCD (int B);
 Bin2BCD = 0;
  for (int i = 0; i < 8; i += 4)
   begin Bin2BCD[i +: 4] = B % 10; B /= 10; end
 endfunction: Bin2BCD 

 function automatic int clog2 (input int n);
  if (n < 1) clog2 = 1;
  else
   for (clog2 = 0; n > 0; n >>= 1) clog2++;
 endfunction: clog2
endmodule: Seconds2EightIndicators