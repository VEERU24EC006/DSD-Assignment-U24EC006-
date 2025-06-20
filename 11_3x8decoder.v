module threeby8decoder (d2,d1,d0,y0,y1,y2,y3,y4,y5,y6,y7);
  input d0,d1,d2;
  output y0,y1,y2,y3,y4,y5,y6,y7;
  wire w1,w2,w3;
  
  not(w1,d2);
  not(w2,d1);
  not(w3,d0);
  
  and(y0,w1,w2,w3);
  and(y1,w1,w2,d0);
  and(y2,w1,d1,w3);
  and(y3,w1,d1,d0);
  and(y4,d2,w2,w3);
  and(y5,d2,w2,d0);
  and(y6,d2,d1,w3);
  and(y7,d2,d1,d0);
  
endmodule 

// testbench
module threeby8_tb;
  reg d2,d1,d0;
  wire y0,y1,y2,y3,y4,y5,y6,y7,w1,w2,w3;
  
 threeby8decoder uut  (.d0(d0),.d1(d1),.d2(d2),.y0(y0),.y1(y1),.y2(y2),.y3(y3),.y4(y4),.y5(y5),.y6(y6),.y7(y7));
    
    initial begin 
      $dumpfile("output.vcd");
      $dumpvars;
    end
    
    initial begin
      d2 = 1'b0; d1= 1'b0; d0 = 1'b0; #10;
      d2 = 1'b0; d1= 1'b0; d0 = 1'b1; #10;
      d2 = 1'b0; d1= 1'b1; d0 = 1'b0; #10;
      d2 = 1'b0; d1= 1'b1; d0 = 1'b1; #10;
      d2 = 1'b1; d1= 1'b0; d0 = 1'b0; #10;
      d2 = 1'b1; d1= 1'b0; d0 = 1'b1; #10;
      d2 = 1'b1; d1= 1'b1; d0 = 1'b0; #10;
      d2 = 1'b1; d1= 1'b1; d0 = 1'b1; #10;
      $finish;
    end
  endmodule