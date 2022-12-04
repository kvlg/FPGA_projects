/*`include "General1.sv" 
`include "DataGenerator.sv" 
`include "Data2Segments.sv" 
`include "Back2Normal.sv"*/

 module DGandD2S (Clock,Button_Up,Button_Reset,Button_Down,SignSwitch,Indicators,Segments);
 parameter Size               =           5,
           Signed             =        "No",
			  Code               =       "Str",
           ClockPeriod_ns     =          20,
           FilterPeriod_ns    =   1_000_000,
           PauseInterval_ns   = 450_000_000,
           RepeatsInterval_ns = 150_000_000,
           RefreshTime_ns     =     200_000; // 5 kHz
 localparam ISize = (Signed == "No") ?
            General1::clog10(1<<Size) :
           (General1::clog10(1<<(Size-1))+1);
 input var bit Clock;
 input  logic Button_Up, Button_Reset, Button_Down, SignSwitch;
 output logic [ISize-1:0] Indicators;
 output logic [ 7:0] Segments;

 logic [Size-1:0] RawData, Data;

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
       B2       (.Clock, .RawData, .SignSwitch, .Data);           
		 
 Data2Segments #(.Size(Size),
                 .Signed(Signed),
			        .Code(Code),
                 .ClockPeriod_ns(ClockPeriod_ns),
                 .RefreshTime_ns(RefreshTime_ns))
       B3       (.Clock, .Data, .Indicators, .Segments);           

endmodule: DGandD2S
