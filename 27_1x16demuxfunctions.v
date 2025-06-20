module oneby16demux_fn(inp,y,sel);
  input inp;
  input[3:0]sel;
  output [15:0]y;
  
  function [15:0] demux;
    input d_inp;
    input [3:0] d_sel;
    integer i;
    
    begin
      demux = 16'b0;
      for(i=0;i<16;i=i+1) begin
        if(d_sel == i)
          d_inp = demux[i];
      end
    end
  endfunction

    
    assign y = demux(inp,sel);

 
endmodule 
//testbench 
`timescale 1ns/1ps
module oneby16_tb;
  reg inp;
  reg[3:0]sel;
  wire[15:0] y;
  integer i;
  
  oneby16demux_fn uut (.inp(inp),.sel(sel),.y(y));
  
  
  initial begin
    $dumpfile("output.vcd");
    $dumpvars;
  end
  
  initial begin
    inp = 1;
    for(i=0;i<16;i=i+1) begin
      sel=i;
      #10;
      $display("time =0%t , sel = 0%d, y = %b",$time,sel,y);
    end
    
    $finish;
  end
    initial begin
  
    inp = 1;
    for(i=0;i<16;i=i+1) begin
      sel=i;
      #10;
     $display("time =0%t , sel = 0%d, y = %b",$time,sel,y);
    end
    $finish;
   end
  
  
endmodule 