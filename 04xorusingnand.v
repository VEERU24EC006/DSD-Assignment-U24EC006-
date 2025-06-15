module xor_nand(x,y,z);
  input x,y;
  output z;
  wire w1,w2,w3;
  
  nand(w1,x,y);
  nand(w2,x,w1);
  nand(w3,y,w1);
  nand(z,w2,w3);
endmodule

//testbench code
module _tb;
  reg x,y;
  wire z, w1,w2,w3,w4;
  xor_nand uut(.x(x), .y(y), .z(z));
  
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    x = 0; y = 0; #10;
    x = 0; y = 1; #10;
    x = 1; y = 0; #10;
    x = 1; y = 1; #10;
    $finish;
  end
endmodule