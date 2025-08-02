module t_ff(
input clk,
input reset,
input tf,
output reg qt);

 always@(posedge clk or posedge reset) begin
    if (reset)
        qt <= 0;
    else if (tf)
        qt<= ~qt;
    end
endmodule    
    
module syncthreebupdcounter(
    input clk,
    input reset,
    input mode,
    output [2:0]qc
    );
    wire t0,t1,t2;
    wire q0,q1,q2;
    
    assign t0 = 1'b1;
    assign t1 = ((mode& ~q0)| (~mode & q0));
    assign t2 = ( (mode & (~q0) & (~q1) )| (~mode & q0 &q1));
  
    t_ff ff0 (.clk(clk),.reset(reset),.qt(q0),.tf(t0));
    t_ff ff1 (.clk(clk),.reset(reset),.qt(q1),.tf(t1));
    t_ff ff2 (.clk(clk),.reset(reset),.qt(q2),.tf(t2));
    
    assign qc = {q2,q1,q0};  

    
endmodulemodule 

//testbench

module syncthreebupdcountertb;
    reg clk;
    reg reset;
    reg mode;
    wire [2:0] qc;
    
    syncthreebupdcounter uut(.clk(clk),.reset(reset),.mode(mode),.qc(qc));
    
    initial begin
        clk =0;
        forever #5 clk = ~clk;
        end
    
    initial begin
    reset = 1;
    mode =0;
    #10; // when reset is on , counter wont start
    
  
    reset=0;
    #100;
    
    mode =1;
    #50;
    
    reset=1;
    #10;
    
    reset=0;
    #50;
    $finish;
    end
endmodule


