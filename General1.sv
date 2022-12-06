`ifndef General1_Done 
`define General1_Done
 package General1;
 typedef bit [31:0]  uint32_t;
 typedef bit [ 7:0]  uint8_t;
 typedef bit [ 3:0]  uint4_t;
 localparam uint4_t Minus = 4'b1010;
 localparam uint4_t Empty = 4'b1111;

// Logarithm functions
 function automatic uint32_t clog10 (uint32_t n);
 if (n < 1)
  clog10 = 1;
 else
  for (clog10 = 0; n > 0; n /= 10)
   clog10++;
 endfunction: clog10

 function automatic uint32_t clog2 (uint32_t n);
 if (n < 1)
  clog2 = 1;
 else
  for (clog2 = 0; n > 0; n >>= 1)
   clog2++;
 endfunction: clog2

// Binary to Binary-Coded Decimal
 function automatic uint32_t Bin2BCD (uint32_t B, Size);
 if (Size == 4)
  Bin2BCD = B;
 else
  begin
   Bin2BCD = 0;
   for (int i = 0; i < Size; i += 4)
    begin
     Bin2BCD[i +: 4] = B % 10;
     B /= 10;
    end
   end
 endfunction: Bin2BCD

// Binary-Coded Decimal to Eight-Segment Code
 function automatic uint8_t BCD2ESC (input uint4_t x);
 uint8_t res;
 (* synthesis, full_case, parallel_case *)
 case (x)
          0 : res = 'b1100_0000;
          1 : res = 'b1111_1001;
          2 : res = 'b1010_0100;
          3 : res = 'b1011_0000;
          4 : res = 'b1001_1001;
          5 : res = 'b1001_0010;
          6 : res = 'b1000_0010;
          7 : res = 'b1111_1000;
          8 : res = 'b1000_0000;
          9 : res = 'b1001_0000;
      Minus : res = 'b1011_1111;
      Empty : res = 'b1111_1111;
 endcase
 return res;
 endfunction: BCD2ESC
 endpackage: General1
 `endif