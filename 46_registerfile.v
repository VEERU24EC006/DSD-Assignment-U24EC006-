module registerfile(
    input clk,
    input we,  //write enable signal 
    input[3:0]waddr,
    input[15:0]wdata, 
   
    
    //port a
    input [3:0] raddr_a, 
    output logic[15:0] rdata_a,
    
    //port b
    input[3:0] raddr_b,
    output logic[15:0] rdata_b
    );
    
    logic[15:0] register [15:0];
    
    always@(posedge clk) begin
        if (we) begin
            register[waddr] <= wdata;
            end
    end
    
    assign rdata_a = register[raddr_a];
    assign rdata_b = register[raddr_b];
    
    
endmodule

//testbench code 

`timescale 1ns / 1ps
module registerfiletb;
    reg we,clk;
    reg [3:0] waddr;
    reg [15:0] wdata;
    reg[3:0] raddr_a,raddr_b;
    wire[15:0] rdata_a,rdata_b;
    
    
    registerfile uut (.clk(clk),
    .we(we),.waddr(waddr),.wdata(wdata),.raddr_a(raddr_a),.rdata_a( rdata_a),.raddr_b(raddr_b),.rdata_b(rdata_b));
    
    always #5 clk = ~clk;
    
    initial begin
    clk =0;
    we = 0;
    raddr_a =0;
    raddr_b=0;
    wdata = 0;
    waddr = 0;
    #10;
    
  @( posedge clk);
    
    we <= 1; //writing 50 to reg 3
    waddr <= 4'd3;
    wdata <= 16'd50;
    #10;
   @(posedge clk); 
    waddr <=4'd5;
    wdata <= 16'd100; // reg 5 
    raddr_a <= 4'd3; // read 3
    #10;
    
   @(posedge clk);
   we <= 0;
   waddr <= 4'd9;
   wdata <= 16'd67;
   raddr_a <= 4'd3;
   raddr_b <= 4'd5;
   #10;
   
   
   #10;
   $finish;
   
   end 
    
    
    
endmodule