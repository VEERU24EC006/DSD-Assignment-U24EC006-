module twobyfour_decoder(d0,d1,y0,y1,y2,y3);
  input d0,d1;
  output y0,y1,y2,y3;
  wire w1,w2;
  
  not(w1,d1);
  not(w2,d0);
  
  and(y0,w1,w2);
  and(y1,d0,w1);
  and(y2,w2,d1);
  and(y3,d0,d1);
endmodule 

// testbench code
module decoder_tb;
  reg d0,d1;
  wire y0,y1,y2,y3,w1,w2;
  
  twobyfour_decoder uut (.d0(d0),.d1(d1),.y0(y0),.y1(y1),.y2(y2),.y3(y3));
  
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    d1 = 1'b0; d0 = 1'b0; #10;
    d1 = 1'b0; d0 = 1'b1; #10;
    d1 = 1'b1; d0 = 1'b0; #10;
    d1 = 1'b1; d0 = 1'b1; #10;
    $finish;
  end
endmodule