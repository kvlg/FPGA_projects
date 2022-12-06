module shift_1100_Moore
 (input  logic Clock, Reset, x,
  output logic y,
  output logic [7:0] st_literal);
 localparam Sequence = 4'b1100,
            Start    = 4'b0000;
 logic [3:0] ShiftRegister = Start;

 always_ff @(posedge Clock, negedge Reset)
 if (~Reset) ShiftRegister <= Start;
 else ShiftRegister <= {ShiftRegister[2:0],x};
 
 always_comb begin
 y = ShiftRegister == Sequence;
 st_literal = 8'b1111_1111;
 end
 
endmodule: shift_1100_Moore