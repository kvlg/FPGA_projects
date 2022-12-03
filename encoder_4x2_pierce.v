module encoder_4x2_pierce (input [3:0] a, output [1:0] b);
// wire [3:0] na;
 wire [1:0] nb;
 wire [1:0] nnb;

// nor (  a[3], na[3], na[3]),     (  a[2], na[2], na[2]),
//     (  a[1], na[1], na[1]);

nor (nnb[1],  a[3],  a[2]),     (nnb[0],  a[3],  a[1]),
    ( nb[1],nnb[1],nnb[1]),     ( nb[0],nnb[0],nnb[0]),
    (  b[1], nb[1], nb[1]),     (  b[0], nb[0], nb[0]);

endmodule