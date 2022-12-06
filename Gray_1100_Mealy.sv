module Gray_1100_Mealy (Clock, Reset, x, y, st_literal);
 input  logic Clock, Reset, x;
 output logic y;
 output logic [7:0] st_literal;

 typedef enum {A = 32'b000000000000000000000000000000_00,
               B = 32'b000000000000000000000000000000_01,
               C = 32'b000000000000000000000000000000_11,
               D = 32'b000000000000000000000000000000_10} states;

 states PState = A, NState;

 always @(posedge Clock, negedge Reset) begin: beep_beep_all_together
  case (PState)
   A : begin NState = (~x) ? A : B; st_literal = 8'b1000_1000; end
   B : begin NState = (~x) ? A : C; st_literal = 8'b1000_0000; end
   C : begin NState = (~x) ? D : C; st_literal = 8'b1100_0110; end
   D : begin NState = (~x) ? A : B; st_literal = 8'b1100_0000; end
  endcase
  
 if (~Reset) PState <= A;
 else PState <= NState;
 
 y = (PState == D)&~x;

 end: beep_beep_all_together

endmodule: Gray_1100_Mealy
