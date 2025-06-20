module threeby8deco_task(inp,y);
  input[2:0]inp;
  output reg[7:0]y;
  
  task decode;
    input[2:0]inpdeco;
    output reg [7:0] y_deco;
    integer i;
    
    begin
      y_deco = 8'b0;
      for(i=0;i<8;i = i+1) begin
        if(i == inpdeco) begin
          y_deco[i] = 1'b1;
        end
      end
    end
  endtask
      
      always @(*) begin
        decode(inp,y);
        end
      
endmodule 

//testbench

module threeby8deco_tb;
  reg[2:0] inp;
  wire[7:0]y;
  integer i;
  
  threeby8deco_task uut (.inp(inp),.y(y));
  
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