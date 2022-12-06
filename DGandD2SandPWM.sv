/*`include "General1.sv" 
`include "DataGenerator.sv" 
`include "Data2Segments.sv" 
`include "PWMGenerator.sv"*/
module DGandD2SandPWM (Clock,Button_Up,Button_Reset,Button_Down,SignSwitch,Indicators,Segments,Synch,PWM,Sign);
 parameter Size               =           5,
           ClockPeriod_ns     =          20,
           FilterPeriod_ns    =   1_000_000,
           PauseInterval_ns   = 450_000_000,
           RepeatsInterval_ns = 150_000_000,
           RefreshTime_ns     =      20_000, // 50 kHz
           PWMPeriod_ns       =     200_000, // 5 kHz
           PWMType            =      "Back",
           Code               =       "Str",
           Signed             =        "No";
 localparam  ISize = (Signed == "No") ?
            General1::clog10(1<<Size) :
           (General1::clog10(1<<(Size-1)) + 1);
 localparam  PWMDSize = (Signed == "No") ?
             Size : Size-1; 

 input  bit   Clock;
 input  logic Button_Up, Button_Reset, Button_Down, SignSwitch;
 output logic [ISize-1:0] Indicators;
 output logic [ 7:0] Segments;
 output logic Synch, PWM, Sign;
 logic [Size-1:0] RawData, Data; 
 logic [PWMDSize-1:0] PWMData;

 DataGenerator #(.Size(Size),
                 .Code(Code),
                 .Signed(Signed),
                 .ClockPeriod_ns(ClockPeriod_ns),
                 .FilterPeriod_ns(FilterPeriod_ns),
                 .PauseInterval_ns(PauseInterval_ns),
                 .RepeatsInterval_ns(RepeatsInterval_ns))
       B1       (.Clock, .Button_Up, .Button_Reset, .Button_Down, .SignSwitch, .RawData);

 Back2Normal   #(.Size(Size),
                 .Signed(Signed),
	              .Code(Code))
       B2       (.Clock, .RawData, .SignSwitch, .Data, .PWMData, .Sign);           
		 
 Data2Segments #(.Size(Size),
                 .Signed(Signed),
	              .Code(Code),
                 .ClockPeriod_ns(ClockPeriod_ns),
                 .RefreshTime_ns(RefreshTime_ns))
       B3       (.Clock, .Data, .Indicators, .Segments);           

PWMGenerator   #(.Size(Size),
                 .ClockPeriod_ns(ClockPeriod_ns),
                 .PWMPeriod_ns(PWMPeriod_ns),
                 .PWMType(PWMType),
					  .Signed(Signed))
       B4       (.Clock, .Data(PWMData), .Synch, .PWM);

endmodule: DGandD2SandPWM