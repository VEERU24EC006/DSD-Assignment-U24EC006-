module jk_ff(
input jf,
input kf,
input reset,
input clk,
output reg qf);

always@(negedge clk or posedge reset) begin
    if(reset)
        qf <= 0;
    else if( jf==0 && kf==1)
        qf <= 0;
    else if(jf==1 && kf==0)
        qf <= 1;
    else if(jf==1 && kf==1)
        qf <= ~qf;
    end
endmodule


module threebupdwonasycounter(
    input reset,
    input clk,
    input mode,
    output [2:0]qc
    );
    wire q0,q1,q2;
    wire clk1, clk2;
    
    assign clk1 = ((~mode&q0)| (mode&~q0));
    assign clk2 = ((~mode&q1)| (mode&~q1));
    

    jk_ff ff1(.reset(reset),.clk(clk),.jf(1'b1),.kf(1'b1),.qf(q0));
    jk_ff ff2(.reset(reset),.clk(clk1),.jf(1'b1),.kf(1'b1),.qf(q1));
    jk_ff ff3(.reset(reset),.clk(clk2),.jf(1'b1),.kf(1'b1),.qf(q2));
    
    assign qc = {q2,q1,q0};
  
    
endmodule 

// testbench code
    module threeasyncchupdowncounter_tb;
    reg reset;
    reg clk;
   reg mode;
    wire[2:0] qc;
    
    
    threebupdwonasycounter uut(.reset(reset),.mode(mode),.clk(clk),.qc(qc));
    
    initial begin
        clk = 0;
      forever #5 clk = ~clk;
        end
        
    initial begin
    reset = 1;
    mode =0;
    #12;
    
    reset= 0;
    #100;
    
    mode = 1;
    #100;
    
    reset = 1;
    #10;
    
    mode = 0;
    #50;
    
    $finish;
    
    end
  
        
endmodule
