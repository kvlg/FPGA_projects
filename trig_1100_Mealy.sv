module D_FlipFlop (Clock, D, Q);
 input Clock, D;
 output reg Q = 0;
 always @(posedge Clock) Q <= D;
 endmodule // D_FlipFlop

module Detector1011_Mealy (Clock, x, y);
 input Clock, x;
 output y;
 wire [1:0] D, b;
 /* f_s */
 assign D[1] = b[0]&~x | b[1]&~b[0]&x,
        D[0] = x;
 /* reg */
 D_FlipFlop DFF0 (Clock, D[0], b[0]),
            DFF1 (Clock, D[1], b[1]);
 /* f_y */
 assign y = b[1] & b[0] & x; 
endmodule // Detector1011_Mealy

