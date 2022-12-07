`include "PWMGenerator.sv" 
module PWMGenerator_tb ();
 timeunit 1ns;
 timeprecision 1ns;
 localparam ClockPeriod_ns = 20,
              PWMPeriod_ns = 20_000,
                   PWMType = "Front",
                      Size = 3;
 var logic Clock = 0;
 var logic [Size-1:0] Data = 'd6;
 var logic PWM, Synch;

PWMGenerator #(.ClockPeriod_ns(ClockPeriod_ns),
               .PWMPeriod_ns(PWMPeriod_ns),
               .PWMType(PWMType),
               .Size(Size))
       PWMG1  (.Clock, .Data, .PWM, .Synch);

 localparam
   t_clk_div2 = ClockPeriod_ns/2,
   N          = 4, // Number Of T_pwm
   Interval   = N*PWMPeriod_ns,
   Repeats    = (2**Size + 1)*Interval/t_clk_div2;
 
 initial repeat (Repeats) #(t_clk_div2) Clock = ~Clock;
 initial begin : test
   for (int i = 0; i < 2**Size; i = i + 1)
     #(Interval) Data = i;
 end : test     
endmodule : PWMGenerator_tb
