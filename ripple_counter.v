// design a memory element

module D_FF(d, clk, rst, q, qn);
  input d, clk, rst;
  output reg q;
  output qn;
  
  always @(posedge clk or posedge rst)
    begin
      if(rst)
        q <= 0;
      else
        q <= d;
    end
  
  assign qn = ~q;
  
endmodule


// Design Counter

module ripple_counter(clk, rst, out);
  input clk, rst;
  output [3:0] out;
  
   wire q0;
  wire qn0;
   wire q1;
  wire qn1;
   wire q2;
  wire qn2;
   wire q3;
  wire qn3;
  
  //   Here we instantiate 4 memory elements (D_FF)
//   FF - 1
  D_FF d0(qn0, clk, rst, q0, qn0);
//   FF - 2
  D_FF d1(qn1, q0, rst, q1, qn1);
//   FF - 3
  D_FF d2(qn2, q1, rst, q2, qn2);
//   FF - 4
  D_FF d3(qn3, q2, rst, q3, qn3);
  
  assign out = {qn3, qn2, qn1, qn0}; 
  
endmodule



-------------------- test bench ---------------------------

module rippleCounter_tb();
  reg clk, rst;
  wire [3:0] out;
  
//   Instantiation
  ripple_counter tb1(clk, rst, out);
  
//   Dump File
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0, rippleCounter_tb);
    end

//   Clock Generations
  
  always #2 clk = ~clk;

// Assigning Values  
  
  initial
    begin
      clk <= 0;
      rst <= 0;
      
      #5; rst = 1;
      #5; rst = 0;
      #60; $finish();
    end
  
//   Displaying Output
  initial
    begin
      $monitor("Out = %h", out);
    end
  
endmodule

// --------------- Output ---------------
# KERNEL: Out = 0
# KERNEL: Out = 1
# KERNEL: Out = 2
# KERNEL: Out = 3
# KERNEL: Out = 4
# KERNEL: Out = 5
# KERNEL: Out = 6
# KERNEL: Out = 7
# KERNEL: Out = 8
# KERNEL: Out = 9
# KERNEL: Out = a
# KERNEL: Out = b
# KERNEL: Out = c
# KERNEL: Out = d
# KERNEL: Out = e
