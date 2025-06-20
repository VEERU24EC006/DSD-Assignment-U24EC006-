module basicgates_mux(a,b,y_and,y_or,y_nand,y_xor);
  input wire a,b;
  output wire y_and,y_or,y_nand,y_xor;
  
  assign y_and =  (~a & 0) + (a & b ) ; // s = a,i0=0, i1=b
  
  assign y_or = ( b & ~a ) + ( 1'b1 & a); // s=a,i0=b,i1=1
  
  assign y_nand = (1'b1 & ~a) + (~b & a); // s=a,i0=1,i1=~b
  
  assign y_xor = ( ~a & b) + ( a & ~b); // s=a,i0=b,i1=b'
  
endmodule
  
  // testbench

  module basicgate_tb;
  reg a,b;
  wire y_and,y_or,y_nand,y_xor;
  
  basicgates_mux uut (.a(a),.b(b),.y_and(y_and),.y_or(y_or),.y_nand(y_nand),.y_xor(y_xor));
  
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
      a = 1'b0; b = 1'b0; #10;
      a = 1'b0; b = 1'b1; #10;
      a = 1'b1; b = 1'b0; #10;
      a = 1'b1; b = 1'b1; #10;
    $finish;
  end
endmodule