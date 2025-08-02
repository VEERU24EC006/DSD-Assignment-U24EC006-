module d_ff(
    input clk,
    input reset,
    input df,
    input initial_one,
    output reg qf
    );

    always@(posedge clk or posedge reset)
        if (reset)
            qf<=(initial_one) ? 1'b1 : 1'b0;
        else 
            qf <= df;
endmodule

module ringcounter(
    input clk,
    input reset,
    output[2:0]qc
    );
    
    wire d0,d1,d2;
    wire q0,q1,q2;
    
    assign d1=q0;
    assign d2 =q1;
    assign d0 =q2;
    
    d_ff ff0(.clk(clk),.reset(reset),.initial_one(1'b1),.qf(q0),.df(d0));
    d_ff ff1(.clk(clk),.reset(reset),.initial_one(1'b0),.qf(q1),.df(d1));
    d_ff ff2(.clk(clk),.reset(reset),.initial_one(1'b0),.qf(q2),.df(d2));
    
    assign qc = {q2,q1,q0};
    
endmodule 

// testbench code
module ringcountertb;
    reg clk;
    reg reset;
    wire[2:0] qc;
    
    ringcounter uut(.clk(clk),.reset(reset),.qc(qc));
    
    initial begin
    clk =0;
    forever #5 clk = ~clk;
    end
    
    initial begin
    reset = 1;
    #10;
    
    reset = 0;
    #100;
    
    
    $finish;
    end
endmodule
