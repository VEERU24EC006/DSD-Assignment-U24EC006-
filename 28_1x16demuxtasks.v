module oneby16demux_task(inp,s,y);
  input inp;
  input [3:0] s;
  output reg [15:0] y;
  
  task demux;
    input d_inp;
    input[3:0]sel;
    output reg [15:0]d_y;
    integer i;
    
    begin
     d_y = 16'b0;
      for(i=0;i<16;i=i+1) begin
        if(i == sel) begin
          d_y[i]= d_inp;
        end
      end
    end
  endtask
  
  always @(*) begin
    demux(inp,s,y);
  end
  
endmodule 
//testbench 
`timescale 1ns/1ps
module oneby16demux_tb;
  reg inp;
  reg [3:0] s;
  wire[15:0] y;
  integer i;
  
  oneby16demux_task uut (.inp(inp),.s(s),.y(y));
  
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    inp = 1;
    for(i=0;i<16;i= i+1) begin
      s = i;
        #10;
        $display("s = %0d, y = %16b",s,y);
    end
      $finish;
    end
endmodule 