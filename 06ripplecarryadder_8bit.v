module full_adder(a,b,cin, cout,sum);
  input a,b,cin;
  output cout, sum;
  
  assign sum  = (a ^ b ^ cin);
  assign cout = (a & b) | (a & cin) | (b & cin) ;
endmodule

module ripple_ca(a,b,cin,cout,sum);
  input [7:0]a,b;
  input cin;
  output [7:0]sum;
  output cout;
  wire [6:0]carry;
  
  full_adder f0(.a(a[0]),.b(b[0]),.cin(cin),.sum(sum[0]),.cout(carry[0]));
  full_adder f1(.a(a[1]),.b(b[1]),.cin(carry[0]),.sum(sum[1]),.cout(carry[1]));
  full_adder f2(.a(a[2]),.b(b[2]),.cin(carry[1]),.sum(sum[2]),.cout(carry[2]));
 full_adder f3(.a(a[3]),.b(b[3]),.cin(carry[2]),.sum(sum[3]),.cout(carry[3]));
 full_adder f4(.a(a[04]),.b(b[4]),.cin(carry[3]),.sum(sum[4]),.cout(carry[4]));
 full_adder f5(.a(a[5]),.b(b[5]),.cin(carry[4]),.sum(sum[5]),.cout(carry[5]));
 full_adder f6(.a(a[6]),.b(b[6]),.cin(carry[5]),.sum(sum[6]),.cout(carry[6]));
 full_adder f7(.a(a[7]),.b(b[7]),.cin(carry[6]),.sum(sum[7]),.cout(cout));  
endmodule

//testbench code

module _tb;
  reg [7:0] a,b;
  reg cin;
  wire [7:0] sum;
  wire cout;
  
  ripple_ca uut (.a(a),.b(b),.cin(cin),.cout(cout),.sum(sum));
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    // basic
	a = 8'b00000000; b = 8'b00000000; cin = 0; #10;
    a = 8'b00000001; b = 8'b00000001; cin = 0; #10;
    // carry propogation
    a = 8'b11111111; b = 8'b11111111; cin = 0; #10;
    a = 8'b11111111; b = 8'b11111111; cin = 1; #10;
    // with cin
    a = 8'b01101100; b = 8'b11101010; cin = 1; #10;
    // random
    a = 8'b11101001; b = 8'b10110100; cin = 0; #10;
    
    // maximum
    a = 8'b11111111; b = 8'b11111111; cin = 1; #10;
    $finish;
  end
endmodule
