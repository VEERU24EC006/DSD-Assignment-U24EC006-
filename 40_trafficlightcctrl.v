module trafficlightctrl(
    input reset,
    input clk,
    output reg [2:0] nsl, // (red,light,green)
    output reg [2:0] ewl
    );
    
    typedef enum reg[1:0]{nsg=2'b00,nsy=2'b01,ewg=2'b10,ewy=2'b11} state_t; //one signal is green/yellow, other is red
    state_t state,next_state;
    
    reg[3:0] timer; // counts clk cycle in each state
    
   localparam green_t = 5;
   localparam yellow_t = 2;
   
   always@(posedge clk or posedge reset)begin
        if(reset)begin
            state <= nsg;
            timer<=0;
            end
   
         else 
             begin
    
                    if((state == nsg && timer == green_t) || (state == nsy && timer == yellow_t) || (state == ewg && timer == green_t) ||
                    (state == ewy && timer == yellow_t)) begin
                     state <= next_state;
                    timer <= 0;
             end 
         else begin
                timer <= timer + 1;
                end
         end  
   end 
   
   always@(*)begin
    case(state)
        nsg : next_state = nsy;
        nsy: next_state = ewg;
        ewg: next_state = ewy;
        ewy: next_state = nsg;
        
        default: next_state = nsg;
     endcase
  end
        
        always@(*)begin
        case(state)
            nsg :begin nsl = 3'b001; ewl = 3'b100; end //red , yellow green
            nsy :begin nsl = 3'b010; ewl = 3'b100; end//red , yellow green
            ewg :begin nsl = 3'b100; ewl = 3'b001; end//red , yellow,green
            ewy :begin nsl = 3'b100; ewl = 3'b010; end//red , yellow, green
            default :begin  nsl = 3'b001; ewl = 3'b100; end
            
            endcase
        end
   endmodule 

   //testbench code 

   module trafficlightctrltb;
reg clk,reset;
wire [2:0] nsl, ewl;

trafficlightctrl uut (.clk(clk),.reset(reset),.nsl(nsl),.ewl(ewl));

initial begin
    clk = 0;
    forever #5 clk = ~clk;
    end
    
initial begin
    reset = 1;
    #10;
    
    reset = 0;
    
    
    repeat(49) begin
    #10;
    end
    $finish;
  end
    
endmodule 