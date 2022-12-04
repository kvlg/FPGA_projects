module DataGenerator (Clock,Button_Up,Button_Reset,Button_Down,SignSwitch,RawData);
 parameter Size               = 5,
           Signed             = "No",
			  Code               = "Str",
           ClockPeriod_ns     = 20,
           FilterPeriod_ns    = 1_000_000,
           PauseInterval_ns   = 400_000_000,
           RepeatsInterval_ns = 150_000_000;
 input var bit  Clock;
 input  var logic Button_Up, Button_Reset, Button_Down, SignSwitch;
 output var logic [Size-1:0] RawData;

 Filter #(.Size(4),
          .ClockPeriod_ns(ClockPeriod_ns),
          .FilterPeriod_ns(FilterPeriod_ns))
        F1   
         (.Clock,
          .I({Button_Up,Button_Reset,Button_Down,SignSwitch}),
          .O({FilteredUp,FilteredReset,FilteredDown,FilteredSignSwitch}));

 PulseGenerator #(.ClockPeriod_ns(ClockPeriod_ns),
                  .PauseInterval_ns(PauseInterval_ns),
                  .RepeatsInterval_ns(RepeatsInterval_ns))
                PG1
                 (.Clock,
                  .iUp(FilteredUp),
                  .iDown(FilteredDown),
                  .iSsw(FilteredSignSwitch),
                  .oUp(Up),
                  .oDown(Down),
                  .oSsw(Ssw));

 DataCounter #(.Size(Size),
               .Signed(Signed),
					.Code(Code))
             DCnt1
              (.Clock,
               .Up,
               .Reset(FilteredReset),
               .Down,
					.SignSwitch(Ssw),
               .Data(RawData));

endmodule: DataGenerator
