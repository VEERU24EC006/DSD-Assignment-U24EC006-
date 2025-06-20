module eightby3encod_task(inp,y);
  input[7:0] inp;
  output reg[2:0] y;

  task encode;
    input[7:0]in_enco;
    output reg[2:0]y_enco;
    reg pri;
    integer i;
    
    begin
      encode = 3'b000;
      pri = 1'b0;
      for(i=0;i<8;i=i+1) begin
        if(!pri && in_enco[i]) begin
          encode = i[2:0];
          pri = 1'b1;
        end
      end
    end
  endtask
  always @(*) begin
    encode(inp,y);
  end
endmodule 

//testbench 
module eightby3enc_tb;
  reg[7:0]inp;
  wire[2:0]y;
  integer i;
  eightby3encod_task uut (.inp(inp),.y(y));
  
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    for(i=0;i<8;i= i+1) begin
      inp = i[2:0];#10;
    end
   $finish;
  end
  
 endmodule
    