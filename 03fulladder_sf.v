module onebit_fa(x,y,z,s,c);
  input x,y,z;
  output s,c;
  wire w1,w2,w3,w4;
  
  xor(w1,x,y);
  xor(s,w1,z);
  
  and(w2,x,y);
  and(w3,x,z);
  and(w4,y,z);
  or(c,w2,w3,w4);
endmodule

//testbench code 
module _tb;
   reg x,y,z;
   wire s,c;
  
  onebit_fa uut(.x(x),.y(y),.z(z),.s(s),.c(c));
  
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin 
    x = 0; y = 0; z = 0; #10;
    x = 0; y = 0; z = 1; #10;
    x = 0; y = 1; z = 0; #10;
    x = 0; y = 1; z = 1; #10;
    x = 1; y = 0; z = 0; #10;
    x = 1; y = 0; z = 1; #10;
    x = 1; y = 1; z = 0; #10;
    x = 1; y = 1; z = 1; #10;
    $finish;
   end
endmodule