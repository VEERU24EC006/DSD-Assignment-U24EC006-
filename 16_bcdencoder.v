module bcd_encoder(bin,bcd1,bcd10);
  input [3:0] bin;
  output [3:0]bcd1,bcd10;
  
  assign bcd10 = (bin>= 4'b1010) ? 4'b0001 : 4'b0000;
  
  assign bcd1 = (bin>= 4'b1010)  ? (bin + 4'b0110) :  bin;
  
endmodule 

//testbench
module bcdenc_tb;
  reg [3:0] bin;
  wire [3:0] bcd1,bcd10;
  
  bcd_encoder uut (.bin(bin),.bcd1(bcd1),.bcd10(bcd10));
  
  initial begin 
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin 
     bin = 4'b0000; #10;
     bin = 4'b0001; #10;
     bin = 4'b0010; #10;
     bin = 4'b0011; #10;
     bin = 4'b0100; #10;
     bin = 4'b0101; #10;
     bin = 4'b0110; #10;
     bin = 4'b0111; #10;
     bin = 4'b1000; #10;
     bin = 4'b1001; #10;
     bin = 4'b1010; #10;
     bin = 4'b1011; #10;
     bin = 4'b1100; #10;
     bin = 4'b1101; #10;
     bin = 4'b1110; #10;
     bin = 4'b1111; #10;
    $finish;
  end 
endmodule