module full_adder(a,b,cin,cout,sum);
  input a,b,cin;
  output sum,cout;
  assign sum = a ^ b ^ cin;
  assign cout = (a&b) | (a & cin) | (b & cin) ;
endmodule
  
module  rca8bit(a,b,cin,cout,sum);
  input [7:0]a,b;
  input cin;
  output[7:0]sum;
  output cout;
  
  wire[8:0]carry;
  assign carry[0] = cin;
  genvar i;
  generate
    for(i=0; i<8; i= i+1) begin : rca_loop
      full_adder fa_inst(a[i], b[i], carry[i], sum[i], carry[i+1]);
    end
  endgenerate
  assign cout = carry[8];
endmodule

module carryselect_adder(a,b,cin,sum,cout);
  input[31:0]a,b;
  input cin;
  output[31:0]sum;
  output cout;
  
  wire[4:0]c;
  wire[7:0] sum0[3:0],sum1[3:0];
  wire[3:0]cout1,cout0;
  assign c[0]= cin;
  
  //for block 0 we use rca
  
  rca8bit rcsa0(a[7:0], b[7:0],c[0],sum[7:0],c[1]);
  
  // for blocks 1-3
  genvar j;
  generate
    for(j=1;j<4; j= j + 1) begin : csa
      rca8bit	rca_0(a[8*j + 7:8*j],b[8*j + 7:8*j], 1'b0,sum0[j],cout0[j]);
      rca8bit	rca_1(a[8*j + 7:8*j],b[8*j + 7:8*j], 1'b1,sum1[j],cout1[j]);
      assign sum[8*j + 7 : 8*j]= c[j] ? sum1[j] : sum0[j];
      assign c[j+1]= c[j] ? cout1[j]: cout0[j];
      end
    endgenerate
    assign cout = c[4];
endmodule 

// testbench code

module tb_carryselectadder;
  reg [31:0]a,b;
  reg cin;
  reg[31:0]sum;
  wire cout;
  
  carryselect_adder uut(.a(a),.b(b),.cin(cin),.cout(cout),.sum(sum));
  
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