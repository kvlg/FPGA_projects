module Gray_1100_Moore (Clock, Reset, x, y, st_literal);
 input  logic Clock, Reset, x;
 output logic y;
 output logic [7:0] st_literal;

 typedef enum {A = 32'b00000000000000000000000000000_000,
               B = 32'b00000000000000000000000000000_001,
               C = 32'b00000000000000000000000000000_011,
               D = 32'b00000000000000000000000000000_010,
               E = 32'b00000000000000000000000000000_110} states;

 states PState = A, NState;

 always @(posedge Clock, negedge Reset) begin: beep_beep_all_together
  case (PState)
   A : begin NState = (~x) ? A : B; st_literal = 8'b1000_1000; end
   B : begin NState = (~x) ? A : C; st_literal = 8'b1000_0000; end
   C : begin NState = (~x) ? D : C; st_literal = 8'b1100_0110; end
   D : begin NState = (~x) ? E : B; st_literal = 8'b1100_0000; end
   E : begin NState = (~x) ? A : B; st_literal = 8'b1000_0110; end
  endcase
  
 if (~Reset) PState <= A;
 else PState <= NState;

 y = (PState == E);
 
 end: beep_beep_all_together

endmodule: Gray_1100_Moore
