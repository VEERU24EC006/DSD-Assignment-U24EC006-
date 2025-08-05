module patterndet(
    input reset,
    input clk,
    input din,
    output reg qp
    );
    
    typedef enum reg[1:0] {S0,S1,S2} state_t;
    state_t state,next_state;
    
    always@(posedge clk or posedge reset)begin
        if(reset)
            state <= S0;
        else
            state <= next_state;
       end
       
       
    always@(*)begin
        case(state)
            S0: next_state = (din)?S1:S0; //pattern =110
            S1: next_state = (din)?S2:S0;
            S2: next_state = (din)?S0:S2;  
         endcase
         
       end
  
  always@(*)begin
    qp = (state ==S2) && (din ==0);
    end      
endmodule


//testbench code 
module patterndetectortb;

reg clk,reset ,din;
wire qp;

patterndet uut(.reset(reset),.clk(clk),.din(din),.qp(qp));

initial begin
clk =0;
forever #5 clk = ~clk;
end

initial begin
reset =1;
#10;

reset = 0;

din =1; #5;
din =1;#5;
din = 0; #5;

din =1; #5;
din =0;#5;
din = 0; #5;

din =0; #5;
din =1;#5;
din = 0; #5;

din =1; #5;
din =1;#5;
din = 1; #5;

din =1; #5;
din =1;#5;
din = 0; #5;

din =0; #5;
din =0;#5;
din = 0; #5;
din =1; #5;
din =1;#5;
din = 0; #5;
din =1; #5;
din =0;#5;
din = 0; #5;
din =1; #5;
din =1;#5;
din = 0; #5;
din =1; #5;
din =1;#5;
din = 0; #5;
din =1; #5;
din =1;#5;
$finish;
end
endmodule 