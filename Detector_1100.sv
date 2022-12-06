module Detector_1100 (Clock,Indicators,Segments);
 timeunit 1ns;
 timeprecision 1ns;

 logic Reset = 1, y;
 logic [15:0] lfsr;
 logic [4:0] data;
 logic [7:0] st_literal;
 input bit Clock;
 output logic [7:0] Indicators, Segments;
 bit flash, Gflash;

 SelectNPulse #(.N( 40_000_200)) S2  (.Clock, .Pulse(flash)); 
 SelectNPulse #(.N(640_000_000)) S3  (.Clock, .Pulse(Gflash)); 

 Galois glfsr (Gflash,lfsr);
 Gray_1100_Moore mut (flash,Reset,data[0],y,st_literal);
 concatenate_zero_bits czb (flash,lfsr,data);
 d2s ds (Clock,data[4:1],y,st_literal,Indicators,Segments);
 
endmodule: Detector_1100