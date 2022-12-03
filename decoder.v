module decoder (clock,j,br,leds,control,value); // top module
 input clock;
 output wire [5:0] j;
 output wire [3:0] br;
 output wire [11:0] leds;
 output wire [7:0] control, value;
 
 johnson_counter jc (enable,j,br,leds);
 show_digits sd (clock,enablesys,control,value,j);
 freq_div #(50000000) fd1  (enable,clock);
 freq_div #(2500) fd2 (enablesys,clock);
 
endmodule

module freq_div (enable, clock);           // module divides the given clock
                                           // frequency by "number"
 parameter number = 50000000;
 output wire enable;
 input clock;
 
 generate if (number > 1) 
 begin 
 reg [$clog2(number)-1:0] counter = 0;
 assign enable = (counter == number - 1);
 always @(posedge clock)
 if (enable) counter <= 0; 
 else
 counter <= counter + 1;
end
 else
 assign enable =    'b1;
 endgenerate

endmodule

module rsff  (q,clock,r,s);
 output reg q = 0;
 input clock, r, s;

always @(posedge clock)
begin
  if (r && s) q <= 1'bx;
  else if (s) q <= 1'b1;
  else if (r) q <= 1'b0;
end
  endmodule

module johnson_counter (clock,q,br,leds);   // module performs Johnson code-based
 input clock;                               // counting in ascending order
 output [5:0] q;
 output reg [3:0] br;
 output reg [11:0] leds;
 reg [5:0] r, s;

 always @*
 case (q)
 'b000000 : {r,s} = 'b?????0000001;
 'b000001 : {r,s} = 'b????0000001?;
 'b000011 : {r,s} = 'b???0000001??;
 'b000111 : {r,s} = 'b??0000001???;
 'b001111 : {r,s} = 'b?0000001????;
 'b011111 : {r,s} = 'b0000001?????;
 'b111111 : {r,s} = 'b000001?????0;
 'b111110 : {r,s} = 'b00001?????00;
 'b111100 : {r,s} = 'b0001?????000;
 'b111000 : {r,s} = 'b001?????0000;
 'b110000 : {r,s} = 'b01?????00000;
 'b100000 : {r,s} = 'b1?????000000;
 endcase

 genvar i;
 generate
 for (i = 0; i < 6; i = i + 1)
 begin : havingfun
 rsff rsffi (q[i],clock,r[i],s[i]);
 end
 endgenerate

always @*
case (q)
 'b000000 : br = 'b0000;
 'b000001 : br = 'b0001;
 'b000011 : br = 'b0010;
 'b000111 : br = 'b0011;
 'b001111 : br = 'b0100;
 'b011111 : br = 'b0101;
 'b111111 : br = 'b0110;
 'b111110 : br = 'b0111;
 'b111100 : br = 'b1000;
 'b111000 : br = 'b1001;
 'b110000 : br = 'b1010;
 'b100000 : br = 'b1011;
endcase

always @*
 case (q)
 'b000000 : leds = 'b111111111110;
 'b000001 : leds = 'b111111111101;
 'b000011 : leds = 'b111111111011;
 'b000111 : leds = 'b111111110111;
 'b001111 : leds = 'b111111101111;
 'b011111 : leds = 'b111111011111;
 'b111111 : leds = 'b111110111111;
 'b111110 : leds = 'b111101111111;
 'b111100 : leds = 'b111011111111;
 'b111000 : leds = 'b110111111111;
 'b110000 : leds = 'b101111111111;
 'b100000 : leds = 'b011111111111;
 endcase
endmodule

module show_digits (clock,enablesys,control,value,j); // module forms a variable "iter"
output wire [7:0] control, value;                     // and sends it to "each_digit"
input clock, enablesys;                               // module to obtain output interface 
input [5:0] j;                                        // values for eight-segment displays
reg [3:0] c;
integer iter = 0;

  each_digit ed (clock,control,value,c,j);
  
always @(posedge enablesys)
  begin
	 if (iter < 8)
	   begin
      c = iter;
		iter = iter + 1;
		end
	 else begin iter = 0;
    end
  end

endmodule

module each_digit (clock,control,value,c,j); // module forms necessary values 
output reg [7:0] control, value;             // for further use in eight-segment 
input clock;                                 // displays as output interface
input [3:0] c;
input [5:0] j;

function [7:0] val;
input reg digit;

    case (digit)
      0 : val = 'b11000000;
      1 : val = 'b11111001;
    endcase

endfunction

always @(posedge clock)
  begin
	 case (c)
		  0 : control = 'b11111110;
		  1 : control = 'b11111101;
		  2 : control = 'b11111011;
		  3 : control = 'b11110111;
		  4 : control = 'b11101111;
		  5 : control = 'b11011111;
		  6 : control = 'b10111111;
		  7 : control = 'b01111111;
	 endcase
    if (c < 6) value = val(j[c]);
	 else if (c == 6) begin
      case (j)
		'b000000 : value = 'b01000000;
      'b000001 : value = 'b01111001;
      'b000011 : value = 'b00100100;
      'b000111 : value = 'b00110000;
      'b001111 : value = 'b00011001;
      'b011111 : value = 'b00010010;
      'b111111 : value = 'b00000010;
      'b111110 : value = 'b01111000;
      'b111100 : value = 'b00000000;
      'b111000 : value = 'b00010000;
      'b110000 : value = 'b01000000;
      'b100000 : value = 'b01111001;
		endcase
	 end
	 else begin
      if ((j == 'b110000) | (j == 'b100000)) value = 'b11111001;
      else                                   value = 'b11000000;
    end
  end

endmodule
