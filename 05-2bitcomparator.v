module twobit_comparator(a,b,eq,ag,bg);
  input [1:0]a;
  input [1:0]b;
  output reg eq,ag,bg;
  
  always @(*) begin
    eq = ((a[1] ~^ b[1]) & (a[0] ~^ b[0]));
    ag = ((a[1] & ~b[1]) | ((a[1] ~^ b[1]) & (a[0] & ~b[0]) ));
    bg = ((~a[1] & b[1]) | ((a[1] ~^ b[1]) & (~a[0] & b[0]) ));
     end
endmodule

// testbench code
module _tb;
  reg [1:0]a,b;
  wire eq,ag,bg;
  
  twobit_comparator uut(.a(a),.b(b),.eq(eq),.ag(ag),.bg(bg));
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
       a = 2'b00; b = 2'b00; #10;
       a = 2'b00; b = 2'b01; #10;
       a = 2'b00; b = 2'b10; #10;
       a = 2'b00; b = 2'b11; #10;
    
       a = 2'b01; b = 2'b00; #10;
       a = 2'b01; b = 2'b01; #10;
       a = 2'b01; b = 2'b10; #10;
       a = 2'b01; b = 2'b11; #10;
    
       a = 2'b10; b = 2'b00; #10;
       a = 2'b10; b = 2'b01; #10;
       a = 2'b10; b = 2'b10; #10;
       a = 2'b10; b = 2'b11; #10;
    
       a = 2'b11; b = 2'b00; #10;
       a = 2'b11; b = 2'b01; #10;
       a = 2'b11; b = 2'b10; #10;
       a = 2'b11; b = 2'b11; #10;
       $finish;
       end
endmodule