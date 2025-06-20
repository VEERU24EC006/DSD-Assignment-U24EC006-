module priority_encoder(y0,y1,y2,y3,v,d0,d1);
  input y0,y1,y2,y3;
  output d0,d1,v;
  wire w1,w2;
  
  
  or(d1,y2,y3);
  or(v,y0,y1,y2,y3);
  not(w1,y2);
  and(w2,w1,y1);
  or(d0,w2,y3);
  
  
endmodule 

// testbench
module priencoder_tb;
  reg y0,y1,y2,y3;
  wire d0,d1,v,w1,w2;
  priority_encoder uut (.y0(y0),.y1(y1),.y2(y2),.y3(y3),.v(v),.d0(d0),.d1(d1));
  
  initial begin 
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    // normal cases
    y3 = 1'b0; y2 = 1'b0; y1 = 1'b0; y0 = 1'b0; #10;
    y3 = 1'b0; y2 = 1'b0; y1 = 1'b0; y0 = 1'b1; #10;
    y3 = 1'b0; y2 = 1'b0; y1 = 1'b1; y0 = 1'b0; #10;
    y3 = 1'b0; y2 = 1'b1; y1 = 1'b0; y0 = 1'b0; #10;
    y3 = 1'b1; y2 = 1'b0; y1 = 1'b0; y0 = 1'b0; #10; 
    
    // multiple input high cases
     y3 = 1'b0; y2 = 1'b0; y1 = 1'b1; y0 = 1'b1; #10;
     y3 = 1'b0; y2 = 1'b1; y1 = 1'b1; y0 = 1'b0; #10;
     y3 = 1'b1; y2 = 1'b1; y1 = 1'b0; y0 = 1'b0; #10;
     y3 = 1'b1; y2 = 1'b1; y1 = 1'b1; y0 = 1'b1; #10;
    
    $finish;
  end 
endmodule