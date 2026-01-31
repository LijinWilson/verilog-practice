// ----------------------- MOD 9 COUNTER -----------------------

// mode9 counter counts from 0 to 9;

// ----------------------- DESIGN -----------------------
// MOD-9 Counter
module mod9_Counter(clk, rst, out);
  input clk;
  input rst;
  output reg [3:0] out;
  
  parameter N = 9;
  
  always @(posedge clk or posedge rst)
    begin
      if(rst)
        out = 0;
      else
        if(out == N)
          out <= 0;
      else 
        out <= out + 1;
    end
  
endmodule
// ----------------------- TEST BENCH -----------------------
module counter_tb();
  reg clk, rst;
  wire [3:0] out;
  
//   Instantiation
  mod9_Counter C1(clk, rst, out);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0, counter_tb);
    end
  
  always #2 clk = ~clk;
  
  initial
    begin
      
      $monitor("Output = %0d", out);
      
      clk <= 0;
      rst <= 0;
      
      #5; rst <= 1;
      #5; rst <= 0;
      #90; $finish();
      
    end
  
endmodule
// ----------------------- OUTPUT -----------------------
# KERNEL: Output = x
# KERNEL: Output = 0
# KERNEL: Output = 1
# KERNEL: Output = 2
# KERNEL: Output = 3
# KERNEL: Output = 4
# KERNEL: Output = 5
# KERNEL: Output = 6
# KERNEL: Output = 7
# KERNEL: Output = 8
# KERNEL: Output = 9
# KERNEL: Output = 0
# KERNEL: Output = 1
