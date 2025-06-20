module thirty2bitboothmulti(mcnd,mplier,prod);
  input signed[31:0]mcnd,mplier; //mulitplicand,multiplier
  output reg signed [63:0]prod;
  integer i;
  reg signed [63:0] a;
  reg signed[31:0] q;
  reg q0;
  
  always @(*) begin
    a = 0;
    q = mplier;
    q0 = 0;
    
    for(i=0;i<32;i=i+1) begin
      if(q[0]==0 && q0==1)
        a = a - mcnd;
      else if(q[0]== 1 && q0==0)
        a = a + mcnd;
      {a,q,q0} = {a,q,q0} >>> 1;
    end
    prod = {a,q};
  end
    
endmodule 
//testbench 
`timescale 1ns/1ps

module thirty2bitboothmulti_tb;
  reg signed [31:0] a, b;
  wire signed [63:0] prod;

 thirty2bitboothmulti uut (.mcnd(a), .mplier(b), .prod(prod));
  initial begin
      $dumpfile("output.vcd");
    $dumpvars;
  end
  

    initial begin
      $monitor("time=0%t, a=%d,b=%d,output = %d",$time,a,b,prod);
        a = 0; b = 1; #10;
        a= -2; b = 3;  #10;
      	a = 255; b =255 ; #10;
        $finish;
    end
endmodule 