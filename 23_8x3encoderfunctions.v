module eightby3enco_fn(inp,y);
  input[7:0]inp;
  output reg[2:0]y;
  integer i;
  
  function reg[2:0] encoder;
    input[7:0]inp_enc;
    reg pri; //priority
      
    begin
      encoder = 3'b000;
      pri = 1'b0; // to check other inputs
      for(i=0;i<8;i= i+1) begin
        if(!pri && inp_enc[i])begin
          encoder = i[2:0];
          pri = 1'b1;
        end
      end
    end
  endfunction
  
  always @(*) begin
    y = encoder(inp);
  end
  
endmodule 
// testbench 
module eightby3enco_tb;
  reg [7:0]inp;
  wire [2:0]y;
  integer i;
  
  eightby3enco_fn uut (.inp(inp),.y(y));
  
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    for(i =0; i<8;i=i+1) begin
      inp = (1 << i);
      #10;
    end
    inp = 8'b00111000;#10;  
  
    $finish;
  end
endmodule