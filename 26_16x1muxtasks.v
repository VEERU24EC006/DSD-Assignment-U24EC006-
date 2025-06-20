module sixteenby1mux_task(inp,y,s);
  input[15:0]inp;
  input [3:0]s;
  output reg y;
  
  task mux;
    input[15:0]in;
    input[3:0]sel;
    output reg out_y;
    integer i;
    begin
      out_y = 1'b0;
      for(i=0;i<16;i = i+1)begin
        if(i == sel) begin
          out_y = in[i];
        end
      end
    end
        endtask
        always @(*) begin
          mux(inp,s,y);
        end
endmodule 
//testbench
module sixteenby1mux_tb;
  reg[15:0]inp;
  reg[3:0]s;
  wire y;
  integer i;
  
  sixteenby1mux_task uut (.inp(inp),.s(s),.y(y));
  
  
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    for(i=0;i<16;i=i+1) begin
      s=i;
      inp = 16'b0;
      inp[i] = 1'b1;
      #10;
    end
    $finish;
   end
  
endmodule 