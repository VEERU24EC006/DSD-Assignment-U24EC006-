module sixteenby1mux_fn(inp,s,y);
  input[15:0]inp;
  input [3:0]s;
  output y;
  
  function reg mux;
    input[15:0]in;
    input[3:0]s;
    integer i;
    begin
      mux = 1'b0;
      for(i=0;i<16;i=i+1) begin
        if(i == s) begin
          mux = in[i];
        end
      end
    end
  endfunction

  assign y = mux(inp,s);
  
  
endmodule 

//testbench
`timescale 1ns/1ps
module sixteenby1mux_tb;
  reg[15:0]inp;
  reg[3:0]s;
  wire y;
  integer i;
  
  sixteenby1mux_fn uut (.inp(inp),.s(s),.y(y));
  
  
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    for(i=0;i<16;i=i+1) begin
      s=i;
      inp = 16'b0;
      inp[i] = 1'b1;
      #10;
      $display(" s = %0d , y = %b",s,y);
    end
    $finish;
   end
  
endmodule