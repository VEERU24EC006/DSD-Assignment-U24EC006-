module twoby4encoder(y0,y1,y2,y3,d0,d1);
  input y0,y1,y2,y3;
  output d0,d1;
  
  or(d1,y3,y2);
  or(d0,y1,y3);
  
endmodule
 //testbench
 module twoby4encoder_tb;
  reg y0,y1,y2,y3;
  wire d0,d1;
  
  twoby4encoder uut (.y0(y0),.y1(y1),.y2(y2),.y3(y3),.d0(d0),.d1(d1));
  
  initial begin 
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    y3 = 1'b0; y2 = 1'b0; y1 = 1'b0; y0= 1'b1; #10;
    y3 = 1'b0; y2 = 1'b0; y1 = 1'b1; y0= 1'b0; #10;
    y3 = 1'b0; y2 = 1'b1; y1 = 1'b0; y0= 1'b0; #10;
    y3 = 1'b1; y2 = 1'b0; y1 = 1'b0; y0= 1'b0; #10;
    $finish;
  end
endmodule 