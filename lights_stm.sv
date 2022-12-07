module lights_stm
 (Clock,Reset,TL,TM,TR,PL,PR,TLsec,TMsec,TRsec,PLsec,PRsec,B);
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
 PSize = clog2((PLSize > PRSize) ? PLSize   : PRSize);
 
 input  bit   Clock;
 input  logic Reset;
 output logic [3:0] TL, TM, TR;
 output logic [1:0] PL, PR;
 output logic [TSize-1:0] TLsec = 0, TMsec = 0, TRsec = 0;
 output logic [PSize-1:0] PLsec = 0, PRsec = 0;
 output logic B;

 SelectNPulse #(.N(20_000_000)) S0 (.Clock, .Pulse(Enable));
 
/* == Constants, internal registers and nets == */
 localparam _YYY__ = 16'b0_0100_0100_0100_00_00, // B_RYGT_RYGT_RYGT_RG_RG
            _RRRGG = 16'b0_1000_1000_1000_01_01,
            BRRRGG = 16'b1_1000_1000_1000_01_01,
            _RRR_G = 16'b0_1000_1000_1000_00_01,
            _OORRG = 16'b0_1100_1100_1000_10_01,
            _TTRRG = 16'b0_0001_0001_1000_10_01,
            BTTRRG = 16'b1_0001_0001_1000_10_01,
            ___RR_ = 16'b0_0000_0000_1000_10_00,
            _YYORR = 16'b0_0100_0100_1100_10_10,
            _RGTRR = 16'b0_1000_0010_0001_10_10,
            BRGTRR = 16'b1_1000_0010_0001_10_10,
            _R__RR = 16'b0_1000_0000_0000_10_10,
            _OYYRR = 16'b0_1100_0100_0100_10_10,
            _GRGGR = 16'b0_0010_1000_0010_01_10,
            BGRGGR = 16'b1_0010_1000_0010_01_10,
            __R_GR = 16'b0_0000_1000_0000_01_10,
            _YRYGR = 16'b0_0100_1000_0100_01_10; 

 enum { Z  =  0, A  =  1, B0 =  2, B1 =  3, B2 =  4,
        B3 =  5, B4 =  6, C  =  7, D  =  8, E0 =  9,
		  E1 = 10, E2 = 11, E3 = 12, E4 = 13, F  = 14,
		  G  = 15, H0 = 16, H1 = 17, H2 = 18, H3 = 19,
  		  H4 = 20, I  = 21, J  = 22, K0 = 23, K1 = 24,
		  K2 = 25, K3 = 26, K4 = 27, L  = 28} PState = Z, NState;
 logic [(PSize>TSize)?PSize:TSize-1:0] WCounter = 0;
 logic Change, Enable;
 assign Change = (WCounter == 0);

/* ===============  State Machine  =============== */
 always_ff @(posedge Clock, negedge Reset) /* begin : jdi */ // f_s
 case (PState)
   Z  : NState <= (Change) ? A  : PState; 
   A  : NState <= (Change) ? B0 : PState;
   B0 : NState <= (Change) ? B1 : PState;
   B1 : NState <= (Change) ? B2 : PState;
   B2 : NState <= (Change) ? B3 : PState;
   B3 : NState <= (Change) ? B4 : PState;
   B4 : NState <= (Change) ? C  : PState; 
   C  : NState <= (Change) ? D  : PState;
   D  : NState <= (Change) ? E0 : PState;
   E0 : NState <= (Change) ? E1 : PState;
   E1 : NState <= (Change) ? E2 : PState;
   E2 : NState <= (Change) ? E3 : PState;
   E3 : NState <= (Change) ? E4 : PState; 
   E4 : NState <= (Change) ? F  : PState;
   F  : NState <= (Change) ? G  : PState;
   G  : NState <= (Change) ? H0 : PState;
   H0 : NState <= (Change) ? H1 : PState;
   H1 : NState <= (Change) ? H2 : PState;
   H2 : NState <= (Change) ? H3 : PState; 
   H3 : NState <= (Change) ? H4 : PState;
   H4 : NState <= (Change) ? I  : PState;
   I  : NState <= (Change) ? J  : PState;
   J  : NState <= (Change) ? K0 : PState;
   K0 : NState <= (Change) ? K1 : PState;
   K1 : NState <= (Change) ? K2 : PState; 
   K2 : NState <= (Change) ? K3 : PState;
   K3 : NState <= (Change) ? K4 : PState;
   K4 : NState <= (Change) ? L  : PState;
   L  : NState <= (Change) ? A  : PState;
 endcase
 always_ff @(posedge Clock, negedge Reset)// register
 if (~Reset)
      PState <= Z;
 else if (Enable)
      PState <= NState;
 always_ff @(posedge Clock, negedge Reset)// f_y
 case (PState)
   Z  : {B,TL,TM,TR,PL,PR} <= _YYY__;
   A  : {B,TL,TM,TR,PL,PR} <= _RRRGG;
   B0 : {B,TL,TM,TR,PL,PR} <= BRRRGG;
   B1 : {B,TL,TM,TR,PL,PR} <= _RRR_G;
   B2 : {B,TL,TM,TR,PL,PR} <= BRRRGG;
   B3 : {B,TL,TM,TR,PL,PR} <= _RRR_G;
   B4 : {B,TL,TM,TR,PL,PR} <= BRRRGG;
   C  : {B,TL,TM,TR,PL,PR} <= _OORRG;
   D  : {B,TL,TM,TR,PL,PR} <= _TTRRG;
   E0 : {B,TL,TM,TR,PL,PR} <= BTTRRG;
   E1 : {B,TL,TM,TR,PL,PR} <= ___RR_;
   E2 : {B,TL,TM,TR,PL,PR} <= BTTRRG;
   E3 : {B,TL,TM,TR,PL,PR} <= ___RR_; 
   E4 : {B,TL,TM,TR,PL,PR} <= BTTRRG;
   F  : {B,TL,TM,TR,PL,PR} <= _YYORR;
   G  : {B,TL,TM,TR,PL,PR} <= _RGTRR;
   H0 : {B,TL,TM,TR,PL,PR} <= BRGTRR;
   H1 : {B,TL,TM,TR,PL,PR} <= _R__RR;
   H2 : {B,TL,TM,TR,PL,PR} <= BRGTRR; 
   H3 : {B,TL,TM,TR,PL,PR} <= _R__RR;
   H4 : {B,TL,TM,TR,PL,PR} <= BRGTRR;
   I  : {B,TL,TM,TR,PL,PR} <= _OYYRR;
   J  : {B,TL,TM,TR,PL,PR} <= _GRGGR;
   K0 : {B,TL,TM,TR,PL,PR} <= BGRGGR;
   K1 : {B,TL,TM,TR,PL,PR} <= __R_GR; 
   K2 : {B,TL,TM,TR,PL,PR} <= BGRGGR;
   K3 : {B,TL,TM,TR,PL,PR} <= __R_GR;
   K4 : {B,TL,TM,TR,PL,PR} <= BGRGGR;
   L  : {B,TL,TM,TR,PL,PR} <= _YRYGR;
 endcase 
/* end : jdi */
/* =========== Working Counter =============== */
 always_ff @(posedge Clock, negedge Reset) 
 if (~Reset)  WCounter <= 0;
 else if (Enable)
  if (Change)
    case (NState)
   Z  :  WCounter <=  5;
   A  :  WCounter <= 15;
   B0 :  WCounter <=  1;
   B1 :  WCounter <=  1;
   B2 :  WCounter <=  1;
   B3 :  WCounter <=  1;
   B4 :  WCounter <=  1;
   C  :  WCounter <=  2;
   D  :  WCounter <= 15;
   E0 :  WCounter <=  1;
   E1 :  WCounter <=  1;
   E2 :  WCounter <=  1;
   E3 :  WCounter <=  1; 
   E4 :  WCounter <=  1;
   F  :  WCounter <=  2;
   G  :  WCounter <= 15;
   H0 :  WCounter <=  1;
   H1 :  WCounter <=  1;
   H2 :  WCounter <=  1;
   H3 :  WCounter <=  1;
   H4 :  WCounter <=  1;
   I  :  WCounter <=  2;
   J  :  WCounter <= 15;
   K0 :  WCounter <=  1;
   K1 :  WCounter <=  1;
   K2 :  WCounter <=  1;
   K3 :  WCounter <=  1;
   K4 :  WCounter <=  1;
   L  :  WCounter <=  2;
 endcase
 else WCounter <= WCounter - 1;

/* ============== Traffic Left Counter ============== */
 always_ff @(posedge Clock, negedge Reset)
 if (~Reset)  TLsec <= 0;
 else if (Enable)
  if (Change)
   case (NState)
     A  :  TLsec <= TL_Red;
     D  :  TLsec <= TL_Green;
     F  :  TLsec <= TL_Red + 2;
     J  :  TLsec <= TL_Green;
	  L  :  TLsec <= TL_Red + 2;
   endcase
  else TLsec <= TLsec - 1;

/* ============== Traffic Mid Counter ============== */
 always_ff @(posedge Clock, negedge Reset)
 if (~Reset)  TMsec <= 0;
 else if (Enable)
  if (Change)
   case (NState)
     D  :  TMsec <= TM_Green + 2;
     G  :  TMsec <= TM_Green;
     I  :  TMsec <= TM_Red + 2;
   endcase
  else TMsec <= TMsec - 1;

/* ============== Traffic Right Counter ============== */
 always_ff @(posedge Clock, negedge Reset)
 if (~Reset)  TRsec <= 0;
 else if (Enable)
  if (Change)
   case (NState)
     A  :  TRsec <= TR_Red;
     G  :  TRsec <= TR_Green + 2;
     J  :  TRsec <= TR_Green;
	  L  :  TRsec <= TR_Red + 2;
   endcase
  else TRsec  <= TRsec - 1;

/* =========== Pedestrian Left Counter ============ */
 always_ff @(posedge Clock, negedge Reset)
 if (~Reset)  PLsec <= 0;
 else if (Enable)
  if (Change)
  case (NState)
     A  :  PLsec <= TL_Red;
     C  :  PLsec <= PL_Red;
     J  :  PLsec <= PL_Green;
   endcase
  else PLsec  <= PLsec - 1;

/* =========== Pedestrian Right Counter ============ */
 always_ff @(posedge Clock, negedge Reset)
 if (~Reset)  PRsec <= 0;
 else if (Enable)
  if (Change)
  case (NState)
     A  :  PRsec <= PR_Green;
     F  :  PRsec <= PR_Red;
   endcase
  else PRsec  <= PRsec - 1;

/////////////////  General function  //////////////////
 function automatic int clog2 (input int n);
 if (n < 1) clog2 = 1;
 else for (clog2 = 0; n > 0; n >>= 1) clog2++;
 endfunction: clog2 
endmodule: lights_stm
