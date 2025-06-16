module full_adder(a,b,cin,sum,cout);
  input a,b,cin;
  output sum,cout;
  assign sum = a ^ b ^ cin;
  assign cout = (a&b) | (a & cin) | (b & cin) ;
endmodule

module rca8bit (a,b,cin,cout,sum);
  input[7:0] a,b;
  input cin;
  output[7:0]sum;
  output cout;
  wire [8:0] carry;
  assign carry[0] = cin;

  genvar i;
  generate
    for(i=0;i<8;i=i+1) begin : rca_loop
 full_adder fa(.a(a[i]), .b(b[i]),.cin(carry[i]),.sum(sum[i]),.cout(carry[i+1]));
    end 
  endgenerate
  assign cout= carry[8];
endmodule

module carryskip_adder (a,b,cin,cout,sum);
  input[7:0]a,b;
  input cin;
  output[7:0]sum;
  output cout;
  wire[7:0]p;
  wire pblock,cblock;
  
  assign p = a ^ b ; 
  
  rca8bit rca(.a(a),.b(b),.cin(cin),.cout(cblock),.sum(sum));
  assign pblock = &p;
  assign cout = pblock ?  cin : cblock;
endmodule

module carryskip_adder32(a,b,cin,cout,sum);
  input[31:0]a,b;
  input cin;
  output[31:0]sum;
  output cout;
  wire[4:0]carry;
  assign carry[0]=cin;
  
  genvar j;
  generate 
    for(j=0; j<4; j= j+1) begin : carryskip_adder32loop   carryskip_adder csa32(.a(a[8*j+7:8*j]),.b(b[8*j+7:8*j]),.cin(carry[j]),.sum(sum[8*j+7:8*j]),.cout(carry[j+1]));
   end 
  endgenerate
 assign cout = carry[4];
endmodule 

//  testbench code 
module carryskip_tb;
  reg[31:0]a,b;
  reg cin;
  wire[31:0]sum;
  wire cout;
  
  carryskip_adder32 uut (.a(a),.b(b),.cin(cin),.sum(sum),.cout(cout));
    
    initial begin 
      $dumpfile("output.vcd");
      $dumpvars;
    end
    
      initial begin
    a = 32'h00000000; b = 32'h00000000; cin=0; #10; // lowest values
    
    a = 32'h00000001; b = 32'h00000001; cin=0; #10; // basic addition
    
    a = 32'hFFFFFFFF; b = 32'h00000001; cin=0; #10; // carry
    
    a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; cin=0; #10; // all 1s
    
    a = 32'hFFFFFFFF; b = 32'hFFFFFFFF; cin=1; #10; // max values
    
    a = 32'h01BC0100; b = 32'h0F100A01; cin=0; #10; // random values
    $finish;
  end   
endmodule