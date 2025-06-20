module eightbitmultiplier(a,b,prod);
  input[7:0]a,b;
  output reg[15:0]prod;
  integer i;
  
  always @(*) begin
    prod = 16'b0;
  
  for(i=0;i<8;i=i+1)begin
    if (b[i])
      prod = prod + (a <<i);
    end
  end
endmodule 

//testbench 
`timescale 1ns/1ps;
module eightbitmulti_tb;
  reg [7:0]a,b;
  wire[15:0]prod;
  integer i;
  
  eightbitmultiplier uut (.a(a),.b(b),.prod(prod));
  
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    $monitor("time = 0%t, a =%8b, b=%8b, prod = %16b(%0d)",$time,a,b,prod,prod);
    
     a = 8'b00000000 ; b = 8'b00000000; #10;
     a = 8'b00000001 ; b = 8'b00000010; #10;
     a = 8'b11111111 ; b = 8'b00000000; #10;
     a = 8'b00000000 ; b = 8'b11111111; #10;
     a = 8'b00101000 ; b = 8'b00100110; #10;
    $finish;
  end
  
endmodule 