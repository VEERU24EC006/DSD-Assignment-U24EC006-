module mealyfsm(
    input clk,
    input reset,
    input inbit,
    output reg q
    );
    
    typedef enum logic[2:0] {S0= 3'b000, S1= 3'b001,S2=3'b010, S3 = 3'b011,S4=3'b100}state_t;
    state_t state, next_state;
    
    always@(posedge clk or posedge reset)begin
        if(reset)
        state <= S0;
        
        else
        state <= next_state;
       end
       
    always@(*)begin
        case(state)
        S0 : next_state = inbit ?S1:S0; // 1011
        S1 : next_state = inbit ?S1:S2;
        S2 : next_state = inbit ?S3:S0;
        S3 : next_state = inbit ?S4:S2;
        
        default: next_state = S0;
        endcase
        end 
        
        always@(*)begin
            case(state)
                S3: q = inbit ?1'b1 : 1'b0; // output = 1 if s3=1
                default: q = 1'b0;
                endcase
            end
            
        
        endmodule 


 / /testbench code

  module mealyfsmtb;
    reg clk,reset,inbit;
    wire q;
    
    mealyfsm uut(.clk(clk),.reset(reset),.inbit(inbit),.q(q));
    
    initial begin
    clk = 0;
    forever #5 clk = ~clk;
    end
    
    initial begin
    reset = 1;
    #10;
    
    reset =0;
    #10;
    
    inbit = 1; #10;
    inbit = 0; #10;
    inbit = 1; #10;
    inbit = 1; #10;
    
    
    inbit = 1; #10;
    inbit = 0; #10;
    inbit = 1; #10;
    inbit = 1; #10;
    
    
    inbit = 1; #10;
    inbit = 0; #10;
    inbit = 0; #10;
    inbit = 1; #10;
    
    #10;
    $finish;
    end
    

endmodule