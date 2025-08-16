`timescale 1ns / 1ps
module multifuncbarrelshifter #(
    parameter  WIDTH = 32,
    parameter SHIFT_WIDTH =5
) ( input wire [WIDTH - 1:0] din,
    input wire [SHIFT_WIDTH - 1:0]shift,
    input wire shiftdir, // 0 left 1 right
    output wire[WIDTH - 1:0] qb
    
 );
 
 wire [WIDTH -1 :0] r0,r1,r2,r3,r4;
 wire[WIDTH - 1 :0] l0,l1,l2,l3,l4;
 
 assign r0 = shift[0] ? din >> 1: din ;
 assign r1 = shift[1] ? r0 >> 2 : r0 ;
 assign r2 = shift[2] ? r1 >> 4 : r1;
 assign r3 = shift[3] ? r2 >> 8 : r2 ;  
 assign r4 = shift[4] ? r3 >> 16 :r3 ;
 
 assign l0 = shift[0] ? din << 1 : din ;
 assign l1 = shift[1] ? l0<< 2 : l0 ;
 assign l2 = shift[2] ? l1 << 4 : l1 ;
 assign l3 = shift[3] ? l2 << 8 : l2 ;  
 assign l4 = shift[4] ? l3 << 16 : l3 ;
 
 
 
 assign qb = shiftdir ? r4: l4;
 
  
endmodule

// testbench code

