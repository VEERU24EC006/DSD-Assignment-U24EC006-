module liftoperation(
    input clk,
    input reset,
    input[2:0] req, // requesting floor in lift
    output reg moving, // lift open 
    output reg open, // door open
    output reg [1:0] floor
    );
    
    typedef enum reg[2:0]{idle0,up0_1,idle1,up1_2,idle2,down2_1,down1_0,down2_0} state_t; // 000,001,010,011,100,101,110
    
    state_t state, next_state;
    
    always@(posedge clk or posedge reset)begin
        if(reset)
        state <= idle0;
        
        else
        state <= next_state;
        end
        
    always@(*)begin
        next_state = state;  // default case or no input
        floor = 2'b00;
        moving =1'b0;
        open = 1'b0; 
       
    case(state)
    
    idle0: begin
    floor = 2'b00; 
    open = req[0]; // door open if 0 floor req
    moving =0;
    
    if(req[2]) next_state = up0_1;
    else if (req[1]) next_state = up0_1;
    else next_state = idle0;
    end
    
    
    up0_1 : begin
    floor = 2'b01;
    moving = 1;
    next_state = idle1;
   end
   
   idle1: begin
   floor = 2'b01;
   moving=0;
   open = req[1];
   if(req[2]) next_state = up1_2;
   else if (req[0]) next_state = down1_0;
   else next_state = idle1;
   end
   
   up1_2:begin
   floor = 2'b10;
   moving =1;
   next_state = idle2;
   end
   
   idle2: begin
   floor = 2'b10;
   moving = 0;
   open = req[2];
   if(req[0]) next_state = down2_0;
   else if(req[1]) next_state = down2_1;
   else next_state = idle2;
   end
   
   down2_1 : begin
   moving = 1;
   floor = 2'b01;
   next_state = idle1;
   end
   
   down1_0: begin
   moving = 1;
   floor = 2'b00;
   next_state = idle0;
   end
   
   down2_0:begin
   moving =1;
   floor = 2'b01;
   next_state = down1_0;
   end
   
   default:begin
   next_state = idle0;
   end
  endcase
 end 

endmodule

//testbench code 

module liftoptb;
 reg clk, reset;
 reg[2:0] req;
 wire[1:0]floor;
 wire moving;
 wire open;
 
 liftoperation uut(.clk(clk),.reset(reset),.req(req),.floor(floor),.moving(moving),.open(open));
 
 initial begin
 clk = 0;
 forever #5 clk = ~clk;
 end
 
 initial begin
 reset = 1;
 req=3'b000; //floor 0 = 001, floor 1 = 010 , floor 2 = 100
 #20;
 
 reset = 0;
 
 req =3'b100; // floor 2 is requested
 #50;
 
 req = 3'b010;
 #50;
 
 req = 3'b001;
 #50;
 $finish;
 
 end
 endmodule 