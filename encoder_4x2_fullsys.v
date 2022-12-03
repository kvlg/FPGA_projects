module encoder_4x2_fullsys (input [3:0] a, output [1:0] b);
 supply1 vcc;
 supply0 gnd;
 wire [3:0] na;
 wire [1:0] nb;
 wire [3:0] nna;
 wire [1:0] nnb;

 // =================== Input inverters =================== //
 nmos niq1 ( na[1],gnd,  a[1]); pmos piq1 ( na[1],vcc,  a[1]);
 nmos niq2 ( na[2],gnd,  a[2]); pmos piq2 ( na[2],vcc,  a[2]);
 nmos niq3 ( na[3],gnd,  a[3]); pmos piq3 ( na[3],vcc,  a[3]);

 // ===================== Encoder 4x2 ===================== //
 nmos niq4 (nna[1],gnd, na[1]); pmos piq4 (nna[1],vcc, na[1]);
 nmos niq5 (nna[2],gnd, na[2]); pmos piq5 (nna[2],vcc, na[2]);
 nmos niq6 (nna[3],gnd, na[3]); pmos piq6 (nna[3],vcc, na[3]);

 rnmos rq1 (nnb[1],vcc,vcc);  
 nmos  q1  (nnb[1],gnd,nna[3]);  nmos q2  (nnb[1],gnd,nna[2]);
 
 rnmos rq2 (nnb[0],vcc,vcc);  
 nmos  q3  (nnb[0],gnd,nna[3]);  nmos q4  (nnb[0],gnd,nna[1]);

 nmos noq0 (nb[0],gnd, nnb[0]);  pmos poq0 (nb[0],vcc,nnb[0]);
 nmos noq1 (nb[1],gnd, nnb[1]);  pmos poq1 (nb[1],vcc,nnb[1]);

 // =================== Output inverters ================== //
 nmos noq2 ( b[0],gnd,  nb[0]);  pmos poq2 ( b[0],vcc, nb[0]);
 nmos noq3 ( b[1],gnd,  nb[1]);  pmos poq3 ( b[1],vcc, nb[1]);

endmodule