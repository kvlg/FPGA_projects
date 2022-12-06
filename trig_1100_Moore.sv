module rsff (q,clk,r,s);
 output reg q = 0;
 input clk, r, s;

 always @(posedge clk)
  if (r && s) q <= 1'bx;
  else if (s) q <= 1'b1;
  else if (r) q <= 1'b0; 
endmodule

module jkff (q,clk,j,k);
 output reg q = 0;
 input clk, j, k;

 always @(posedge clk)
  if (j && k) q <= ~q;
  else if (j) q <= 1'b0;
  else if (k) q <= 1'b1; 
endmodule

module dff (q,clk,d);
 output reg q = 0;
 input clk, d;

 always @(posedge clk)
  q <= d; 
endmodule

module tff (q,clk,t);
 output reg q = 0;
 input clk, t;

 always @(posedge clk)
  if (t) q <= ~q; 
endmodule

module mealy_output (mealy_out,clk,b_1,b_0,x);
 output reg mealy_out = 0;
 input clk, b_1, b_0, x;

 always @(posedge clk)
  mealy_out <= b_1& b_0&~x;
endmodule

`timescale 1ns/1ns 
module trig_1100_Moore (Clock, x, y);
 localparam Trigtype      = "jk",
            StMachinetype = "Mealy";
 input Clock, x;
 output y; 

 genvar i;
 generate
  if ((Trigtype == "rs") && (StMachinetype == "Moore")) begin
   wire [2:0] r, s, b;
   assign r[2] =  b[2],
          r[1] =  b[1]& b[0],
          r[0] = ~b[1]& b[0] | b[0]&~x,
          s[2] =  b[1]& b[0]&~x,
          s[1] = ~b[1]& b[0]& x,
          s[0] = ~b[1]&~b[0]& x | b[1]&~b[0]&~x,
          y    =  b[2];
   for (i = 0; i < 3; i = i + 1) begin
    rsff rsffi (b[i],Clock,r[i],s[i]); end
  end
  else if ((Trigtype == "jk") && (StMachinetype == "Moore")) begin
   wire [2:0] j, k, b;
   assign j[2] =  1,
          j[1] =  b[0],
          j[0] = ~b[1] | ~x,
          k[2] =  b[1]& b[0]&~x,
          k[1] =  b[0]& x,
          k[0] = ~b[1]& x | b[1]&~x,
          y    =  b[2];
   for (i = 0; i < 3; i = i + 1) begin
    jkff jkffi (b[i],Clock,j[i],k[i]); end
  end
  else if ((Trigtype == "d") && (StMachinetype == "Moore")) begin
   wire [2:0] d, b;
   assign d[2] =  b[1]& b[0]&~x,
          d[1] = ~b[1]& b[0]& x | b[1]&~b[0],
          d[0] = ~b[1]&~b[0]& x | b[1]&~b[0]&~x | b[1]& b[0]& x,
          y    =  b[2];
   for (i = 0; i < 3; i = i + 1) begin
    dff dffi (b[i],Clock,d[i]); end
  end
  else if ((Trigtype == "t") && (StMachinetype == "Moore")) begin
   wire [2:0] t, b;
   assign t[2] =  b[2] | b[1]& b[0]&~x,
          t[1] =  b[0]& x | b[1]& b[0],
          t[0] = ~b[1]& x | b[1]&~x | ~b[1]& b[0],
          y    =  b[2];
   for (i = 0; i < 3; i = i + 1) begin
    tff tffi (b[i],Clock,t[i]); end
  end
  else if ((Trigtype == "rs") && (StMachinetype == "Mealy")) begin
   wire [1:0] r, s, b;
   wire mealy_out;
   assign r[1] =  b[1]& b[0],
          r[0] = ~b[1]& b[0] | b[0]&~x,
          s[1] = ~b[1]& b[0]& x,
          s[0] = ~b[1]&~b[0]& x | b[1]&~b[0]&~x,
          y    =  mealy_out;
    mealy_output mo (mealy_out,Clock,b[1],b[0],x);
   for (i = 0; i < 2; i = i + 1) begin
    rsff rsffi (b[i],Clock,r[i],s[i]); end
  end
  else if ((Trigtype == "jk") && (StMachinetype == "Mealy")) begin
   wire [1:0] j, k, b;
   wire mealy_out;
   assign j[1] =  b[0],
          j[0] = ~b[1] | ~x,
          k[1] =  b[0]& x,
          k[0] = ~b[1]& x | b[1]&~x,
          y    =  mealy_out;
    mealy_output mo (mealy_out,Clock,b[1],b[0],x);
   for (i = 0; i < 2; i = i + 1) begin
    jkff jkffi (b[i],Clock,j[i],k[i]); end
  end
  else if ((Trigtype == "d") && (StMachinetype == "Mealy")) begin
   wire [1:0] d, b;
   wire mealy_out;
   assign d[1] = ~b[1]& b[0]& x | b[1]&~b[0],
          d[0] = ~b[1]&~b[0]& x | b[1]&~b[0]&~x | b[1]& b[0]& x,
          y    =  mealy_out;
    mealy_output mo (mealy_out,Clock,b[1],b[0],x);
   for (i = 0; i < 2; i = i + 1) begin
    dff dffi (b[i],Clock,d[i]); end
  end
  else if ((Trigtype == "t") && (StMachinetype == "Mealy")) begin
   wire [1:0] t, b;
   wire mealy_out;
   assign t[1] =  b[0]& x | b[1]& b[0],
          t[0] = ~b[1]& x | b[1]&~x | ~b[1]& b[0],
          y    =  mealy_out;
    mealy_output mo (mealy_out,Clock,b[1],b[0],x);
   for (i = 0; i < 2; i = i + 1) begin
    tff tffi (b[i],Clock,t[i]); end
  end
 endgenerate
endmodule
