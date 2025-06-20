module gray_encoder (b0,b1,b2,g0,g1,g2);
  input b0,b1,b2;
  output g0,g1,g2;
  
  assign g2 = b2;
  
  xor(g1,b2,b1);
  xor(g0,b1,b0);
  
endmodule
// testbench 
  reg b0,b1,b2;
  wire g0,g1,g2;
  
  gray_encoder uut (.b0(b0),.b1(b1),.b2(b2),.g0(g0),.g1(g1),.g2(g2));
  
  initial begin 
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    
   	  b2 = 1'b0; b1 = 1'b0; b0 = 1'b0; #10;
      b2 = 1'b0; b1 = 1'b0; b0 = 1'b1; #10;
      b2 = 1'b0; b1 = 1'b1; b0 = 1'b0; #10;
      b2 = 1'b0; b1 = 1'b1; b0 = 1'b1; #10;
      b2 = 1'b1; b1 = 1'b0; b0 = 1'b0; #10;
      b2 = 1'b1; b1 = 1'b0; b0 = 1'b1; #10;
      b2 = 1'b1; b1 = 1'b1; b0 = 1'b0; #10;
      b2 = 1'b1; b1 = 1'b1; b0 = 1'b1; #10;
      $finish;
  end
endmodule
    
    
  
  