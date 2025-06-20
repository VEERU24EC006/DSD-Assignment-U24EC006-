module threeby8encoder(y0,y1,y2,y3,y4,y5,y6,y7,d2,d1,d0);
  input y0,y1,y2,y3,y4,y5,y6,y7;
  output d0,d1,d2;
  
  or(d2,y4,y5,y6,y7);
  or(d1,y2,y3,y6,y7);
  or(d0,y1,y3,y5,y7);
  
endmodule 
//testbench
module threeby8enc_tb;
  reg y0,y1,y2,y3,y4,y5,y6,y7;
  wire d0,d1,d2;
  
  threeby8encoder uut (.y0(y0),.y1(y1),.y2(y2),.y3(y3),.y4(y4),.y5(y5),.y6(y6),.y7(y7),.d2(d2),.d1(d1),.d0(d0));
  initial begin 
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    y7 = 1'b0; y6 = 1'b0; y5= 1'b0; y4 = 1'b0; y3 = 1'b0; y2 = 1'b0; y1= 1'b0; y0 = 1'b1; #10;
    
       y7 = 1'b0; y6 = 1'b0; y5= 1'b0; y4 = 1'b0; y3 = 1'b0; y2 = 1'b0; y1= 1'b1; y0 = 1'b0; #10;
       y7 = 1'b0; y6 = 1'b0; y5= 1'b0; y4 = 1'b0; y3 = 1'b0; y2 = 1'b1; y1= 1'b0; y0 = 1'b0; #10;
       y7 = 1'b0; y6 = 1'b0; y5= 1'b0; y4 = 1'b0; y3 = 1'b1; y2 = 1'b0; y1= 1'b0; y0 = 1'b0; #10;
       y7 = 1'b0; y6 = 1'b0; y5= 1'b0; y4 = 1'b1; y3 = 1'b0; y2 = 1'b0; y1= 1'b0; y0 = 1'b0; #10;
       y7 = 1'b0; y6 = 1'b0; y5= 1'b1; y4 = 1'b0; y3 = 1'b0; y2 = 1'b0; y1= 1'b0; y0 = 1'b0; #10;
       y7 = 1'b0; y6 = 1'b1; y5= 1'b0; y4 = 1'b0; y3 = 1'b0; y2 = 1'b0; y1= 1'b0; y0 = 1'b0; #10;
       y7 = 1'b1; y6 = 1'b0; y5= 1'b0; y4 = 1'b0; y3 = 1'b0; y2 = 1'b0; y1= 1'b0; y0 = 1'b0; #10;
   
    $finish;
  end 
endmodule