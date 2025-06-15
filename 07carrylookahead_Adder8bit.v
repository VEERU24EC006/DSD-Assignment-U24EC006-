module cla_adder #(parameter n = 8)(a,b,cin,cout,sum);
  input [n-1 : 0] a,b;
  input cin;
  output[n-1 : 0] sum;
  output cout;
  
  wire [n-1 : 0]p,g;
  wire[n : 0]c;
  
  assign p = (a ^ b);
  assign g = (a & b);
  assign c[0] = cin;
  
  genvar i;
  generate 
    for( i = 0; i < n ; i= i + 1) begin : cla_loop
      assign sum[i] = (p[i] ^ c[i]);
      assign c[i+1] = g[i] | (p[i] & c[i]) ;
    end 
  endgenerate
  
  assign cout = c[n];
  
endmodule 

//testbench code 
module _tb #(parameter n = 8);
  reg[n-1:0]a,b;
  reg cin;
  wire[n-1:0]sum;
  wire cout;
  
  cla_adder uut(.a(a),.b(b),.cin(cin),.cout(cout),.sum(sum));
  initial begin
  $dumpfile("output.vcd");
  $dumpvars;
  end
  
  initial begin
    a = 8'b00000000; b = 8'b00000000; cin = 0; #10; // all zeroes
    
    a = 8'b00000001; b = 8'b00000001; cin = 0; #10; // basic
    
    a = 8'b00000000; b = 8'b00000001; cin = 1; #10; // one zero 
   
    a = 8'b00000001; b = 8'b00000001; cin = 1; #10; // with cin 
    
    a = 8'b01001101; b = 8'b00101011; cin = 0; #10; // random
    
    a = 8'b11111111; b = 8'b11111111; cin = 1; #10; // one zero
    
    $finish;
  end
endmodule