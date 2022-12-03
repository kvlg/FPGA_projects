module encoder_4x2_sheffer (input [3:0] a, output [1:0] b);

   assign b[1] = ~(~(~(a[3] & a[3]) 
                   & ~(a[2] & a[2])) 
                 & ~(~(a[3] & a[3]) 
                   & ~(a[2] & a[2]))),
          b[0] = ~(~(~(a[3] & a[3]) 
                   & ~(a[1] & a[1])) 
                 & ~(~(a[3] & a[3]) 
                   & ~(a[1] & a[1]))); 

endmodule