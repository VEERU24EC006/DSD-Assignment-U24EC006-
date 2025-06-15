// design code 
// one bit full adder dataflow modelling
module onebit_fa(x, y, z, s, c);
  input x, y, z;
  output s, c;
  assign s = x ^ y ^ z;
  assign c = (x & y) | (x & z) | (y & z);
endmodule 

// testbench 

module tb_adder;
  reg x,y,z;
  output s,c;
  
  onebit_fa uut(.x(x), .y(y), .z(z), .s(s), .c(c));
  // dataflow modelling
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end;
  initial begin
    x = 0; y = 0 ; z = 0 ; #10;
    x = 0; y = 0 ; z = 1 ; #10;
    x = 0; y = 1 ; z = 0 ; #10;
    x = 0; y = 1 ; z = 1 ; #10;
    x = 1; y = 0 ; z = 0 ; #10;
    x = 1; y = 0 ; z = 1 ; #10;
    x = 1; y = 1 ; z = 0 ; #10;
    x = 1; y = 1 ; z = 1 ; #10;
    $finish;
  end
endmodule