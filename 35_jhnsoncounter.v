module d_ff(
    input clk,
    input reset,
    input df,
    output reg qf
    );
    
    always@(posedge clk or posedge reset) begin
        if (reset)
            qf<= 0 ;
        else 
            qf <= df;
        end
endmodule

module jhnsoncounter(
    input clk,
    input reset,
    output  [2:0] qc
    );
    wire df0,df1,df2;
    wire q0,q1,q2;
    
    assign df1 = q0;
    assign df2 = q1;
    assign df0 = ~q2;
    
     d_ff ff0 (.clk(clk),.reset(reset),.df(df0),.qf(q0));
     d_ff ff1 (.clk(clk),.reset(reset),.df(df1),.qf(q1));
     d_ff ff2 (.clk(clk),.reset(reset),.df(df2),.qf(q2));
     
     assign qc = {q2,q1,q0};
     
endmodule 

//testbench 
module jhnsoncounter_tb;
    reg clk;
    reg reset;
    wire [2:0]qc; 
    
    jhnsoncounter uut (.clk(clk),.reset(reset),.qc(qc));
    
    initial begin
    clk = 0;
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