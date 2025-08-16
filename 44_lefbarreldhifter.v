module lefbarrelshifter #(
    parameter WIDTH =32,
    parameter Shiftwidth = 5
) (
    input wire [WIDTH-1:0]din,
    input wire [Shiftwidth - 1:0]shift,
    output wire [WIDTH - 1:0]qb
    );
    
    wire[WIDTH-1:0] s0,s1,s2,s3,s4;
    
    assign s0= shift[0]?(din<<1) : din;
    
    assign s1= shift[1]? (s0<<2) : s0;
    
    assign s2 =shift[2]? (s1<<4): s1;
    
    assign s3 = shift[3]?(s2<<8):s2;
    
    assign s4 = shift[4]?(s3<<16):s3;
    
    assign qb = s4;
    
 endmodule

 //testbench code

 module lefshiftertb;

  parameter WIDTH =32;
  parameter Shiftwidth = 5;
 
  reg [WIDTH-1:0]din;
  reg  [Shiftwidth - 1:0]shift;
  wire [WIDTH - 1:0]qb;
  
    
 wire[WIDTH-1:0] s0,s1,s2,s3,s4;
 
 lefbarrelshifter  #(.WIDTH(32),.Shiftwidth(5))
  uut (.din(din),.shift(shift),.qb(qb));
 
 initial begin
 din = 32'b0;
 shift = 4'b0;
 #10;
 
 din = 32'hFFFF0000;
 shift =4'b0011;
 #10;
 
 din = 32'h00001111;
 shift = 4'b0100;
 #10;
 $finish;
 
 end
 
 endmodule