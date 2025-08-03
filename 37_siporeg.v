module d_ff(
    input clk,
    input reset,
    input df,
    output reg qf
    );
    
    always@(posedge clk or posedge reset)begin
    if(reset)
        qf <= 0;
    else 
        qf <= df;
    end
 endmodule

module siporeg(
    input clk,
    input reset,
    input dr,
    output[3:0] qr
    );
    
    wire d0,d1,d2,d3;
    wire q0,q1,q2,q3;
    
    
    d_ff ff0 (.clk(clk),.reset(reset),.df(dr),.qf(q0));
    d_ff ff1 (.clk(clk),.reset(reset),.df(q0),.qf(q1));
    d_ff ff2 (.clk(clk),.reset(reset),.df(q1),.qf(q2));
    d_ff ff3 (.clk(clk),.reset(reset),.df(q2),.qf(q3));
    
    assign qr = {q3,q2,q1,q0};
    
   
endmodule


//testbench code

module siporegtb;
    reg reset;
    reg clk;
    reg dr;
    wire[3:0] qr;
   
   siporeg uut (.reset(reset),.clk(clk),.dr(dr),.qr(qr));
   initial begin
   clk = 0;
   forever #5 clk = ~clk;
   end
   
   initial begin
   reset = 1;
   #10;
   
   reset = 0;
   dr = 1;
   #100;
   
   $finish;
   end
   
   endmodule
   