module fourby1mux(s0,s1,i0,i1,i2,i3,y);
  input s0,s1,i0,i1,i2,i3;
  output y;
  
  assign y = (~s1 & ~s0 & i0) + (~s1 & s0 & i1) + (s1 & ~s0 & i2) +  (s1 & s0 & i3); 
  
endmodule

// testbench

module four1mux_tb;
  reg s0,s1,i0,i1,i2,i3;
  wire y;
  reg [3:0]inp;
  reg[1:0]sel;
  
  
  fourby1mux uut (.s0(s0),.s1(s1),.i0(i0),.i1(i1),.i2(i2),.i3(i3),.y(y));
  integer i,j;

  
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end

  
  initial begin
    for( i =0; i <4; i = i + 1) begin 
      sel = i;
      s1 = sel[1];
      s0 = sel[0];
     
      for( j = 0 ; j <16 ; j = j + 1) begin 
        inp = j;
        i3 = inp[3];
        i2 = inp[2];
        i1 = inp[1];
        i0 = inp[0];
        
        #10;
    end
  end