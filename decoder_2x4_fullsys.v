module decoder_2x4_fullsys (input [1:0] a, output [3:0] b);
 supply1 vcc;
 supply0 gnd;
 wire [1:0] na;
 wire [3:0] nb;

   pmos pqin1 (na[0],vcc,a[0]); nmos nqin1 (na[0],gnd,a[0]);  // input cmos
   pmos pqin2 (na[1],vcc,a[1]); nmos nqin2 (na[1],gnd,a[1]);  // inverters
  
   // ------ b[3] ------ //

   rnmos rq31 (nb[3],vcc,vcc);
   nmos   q31 (nb[3],gnd,na[0]); nmos   q32 (nb[3],gnd,na[1]);
   pmos pqout3 (b[3],vcc,nb[3]); nmos nqout3 (b[3],gnd,nb[3]); // output cmos inverter

   // ------ b[2] ------ //

   rnmos rq21 (nb[2],vcc,vcc);
   nmos   q21 (nb[2],gnd, a[0]); nmos   q22 (nb[2],gnd,na[1]);
   pmos pqout2 (b[2],vcc,nb[2]); nmos nqout2 (b[2],gnd,nb[2]); // output cmos inverter

   // ------ b[1] ------ //

   rnmos rq11 (nb[1],vcc,vcc);
   nmos   q11 (nb[1],gnd,na[0]); nmos    q12 (nb[1],gnd, a[1]);
   pmos pqout1 (b[1],vcc,nb[1]); nmos nqout1 ( b[1],gnd,nb[1]); // output cmos inverter

   // ------ b[0] ------ //

   rnmos rq01 (nb[0],vcc,vcc);
   nmos   q01 (nb[0],gnd, a[0]); nmos   q02 (nb[0],gnd, a[1]);
   pmos pqout0 (b[0],vcc,nb[0]); nmos nqout0 (b[0],gnd,nb[0]); // output cmos inverter

endmodule