module sixteenbitmultiplier(a,b,prod);
  input[15:0]a,b;
  output reg[31:0]prod;
  integer i;
  
  always @(*) begin
    prod = 32'b0;
  
    for(i=0;i<16;i=i+1)begin
    if (b[i])
      prod = prod + (a <<i);
    end
  end
endmodule 

//testbench 
`timescale 1ns/1ps;
module sixteenbitmulti_tb;
  reg [15:0]a,b;
  wire[31:0]prod;
  integer i;
  
  sixteenbitmultiplier uut (.a(a),.b(b),.prod(prod));
  
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    $monitor("time =0%t, a =%16b, b=%16b, prod = %32b(%0d)",$time,a,b,prod,prod);
    
     a = 8'b00000000 ; b = 8'b00000000; #10;
    
     a = 8'b00000001 ; b = 8'b00000001; #10;
     a = 8'b11111111 ; b = 8'b00000000; #10;
     a = 8'b00000000 ; b = 8'b11111111; #10;
     a = 8'b00100000 ; b = 8'b00100110; #10;
    $finish;
  end
  
endmodule 