/*`include "unar_1100_Moore.sv"
`include "unar_1100_Mealy.sv"
`include "bin_1100_Moore.sv"
`include "bin_1100_Mealy.sv"
`include "Gray_1100_Moore.sv"
`include "Gray_1100_Mealy.sv"
`include "Johnson_1100_Moore.sv"
`include "trig_1100_Moore.sv"
`include "shift_1100_Moore.sv"
`include "Galois.sv"*/
module Detector_1100_tb ();
 timeunit 1ns;
 timeprecision 1ns;
 logic [15:0] lfsr;
 logic Clock = 0, Reset = 1, x = 0, y;

 Galois glfsr (Clock,lfsr);
 Johnson_1100_Moore mut (Clock,Reset,lfsr[0],y);

 initial repeat (100) #5 Clock = ~Clock;

endmodule: Detector_1100_tb
