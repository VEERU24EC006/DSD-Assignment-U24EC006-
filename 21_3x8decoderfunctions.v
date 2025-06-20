module threeby8_deco(inp,y);
  input[2:0] inp;
  output reg[7:0] y;
  
  function reg[7:0]decode;
    input [2:0]inpdeco;
    integer i;
    
    begin
      decode = 8'b0;
 
    for (i=0; i<8; i = i+1) begin
      if (i == inpdeco) begin
        decode[i] = 1'b1;
      end
    end
   end
  endfunction
 
      always@(*) begin
        y = decode(inp);
      end
endmodule 

// testbench
module threeby8_tb;
  reg [2:0]inp;
  wire [7:0]y;
  
  integer i;
  
  threeby8_deco uut (.inp(inp),.y(y));
  
  
  initial begin 
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    for(i=0;i<8;i= i +1) begin
      inp = i[2:0]; #10;
    end
    $finish;
  end
endmodule