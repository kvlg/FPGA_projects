module unar_1100_Mealy (Clock, Reset, x, y, st_literal);
 input  logic Clock, Reset, x;
 output logic y;
 output logic [7:0] st_literal;

 localparam A_BIT = 0,
            B_BIT = 1,
            C_BIT = 2,
            D_BIT = 3;

 typedef enum {A = 32'b0000000000000000000000000000_0001 << A_BIT,
               B = 32'b0000000000000000000000000000_0001 << B_BIT,
               C = 32'b0000000000000000000000000000_0001 << C_BIT,
               D = 32'b0000000000000000000000000000_0001 << D_BIT} states;

 states PState = A, NState;

 always @(posedge Clock, negedge Reset) begin: beep_beep_all_together
  unique case (1'b1)
   PState[A_BIT] : begin NState = (~x) ? A : B; st_literal = 8'b1000_1000; end
   PState[B_BIT] : begin NState = (~x) ? A : C; st_literal = 8'b1000_0000; end
   PState[C_BIT] : begin NState = (~x) ? D : C; st_literal = 8'b1100_0110; end
   PState[D_BIT] : begin NState = (~x) ? A : B; st_literal = 8'b1100_0000; end
  endcase
  
 if (~Reset) PState <= A;
 else PState <= NState;

 y = PState[D_BIT]&~x;
 
 end: beep_beep_all_together

endmodule: unar_1100_Mealy
