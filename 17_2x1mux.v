module twoby1mux(i0,i1,y,s0);
  input i0,i1,s0;
  output y;
  
  assign y = (i0 & ~s0) | (i1 & s0) ; 
  
endmodule 
// testbench 
module two1mux_tb;
  reg i0,i1,s0;
  wire y;
  
  twoby1mux uut (.i0(i0),.i1(i1),.y(y),.s0(s0));
  
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
  	   i0 = 1'b0; i1 = 1'b0; s0 = 1'b0; #10;
       i0 = 1'b0; i1 = 1'b1; s0 = 1'b0; #10;
       i0 = 1'b1; i1 = 1'b0; s0 = 1'b0; #10;
       i0 = 1'b1; i1 = 1'b1; s0 = 1'b0; #10;
    
       i0 = 1'b0; i1 = 1'b0; s0 = 1'b1; #10;
       i0 = 1'b0; i1 = 1'b1; s0 = 1'b1; #10;
       i0 = 1'b1; i1 = 1'b0; s0 = 1'b1; #10;
       i0 = 1'b1; i1 = 1'b0; s0 = 1'b1; #10;
    
    
    
  
    $finish;
    
  end
endmodule 