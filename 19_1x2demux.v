module twoby1demux(i,s0,y0,y1);
  input i,s0;
  output y0,y1;
  
  assign y0 = ~s0 & i;
  assign y1 = s0 & i;
endmodule

//testbench

module two1demux_tb;
  reg s0,i;
  wire y0,y1;
  
  twoby1demux uut (.i(i),.s0(s0),.y0(y0),.y1(y1));
  
  initial begin
  $dumpfile("output.vcd");
  $dumpvars;
  end
  
  initial begin
    
    i = 1'b0; s0 = 1'b0; #10;
    i = 1'b0; s0 = 1'b1; #10;
    i = 1'b1; s0 = 1'b0; #10;
    i = 1'b1; s0 = 1'b1; #10;
    $finish;
  end
endmodule