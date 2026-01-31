// --------------- RING COUNTER ---------------
// Output is fed back to the input
// 4 bit ring counter

// --------------- DESIGN ---------------
module ring_counter(clk, rst, out);
  input clk, rst;
  output reg [3:0] out;
  
  always @(posedge clk or posedge rst)
    begin
      if(rst)
        begin
          out <= 1;
        end
      else
        begin
          out[3] <= out[0];
          for(int i=0; i < 3; i = i+1)
            begin
              out[i] <= out[i+1];
            end
        end
    end
endmodule

// --------------- TEST BENCH ---------------
module ringCounter_tb();
  reg clk, rst;
  wire [3:0] out;
  
// -------------- Instantiation --------------
  ring_counter tb1(clk, rst, out);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0, ringCounter_tb);
    end
  
  always #2 clk = ~clk;
  
  initial
    begin
      
      $monitor("Output = %b", out);
      
      clk <= 0;
      rst <= 1;
      
      #5; rst = 0;
      #25; $finish();
    end
endmodule
// --------------- OUTPUT ---------------
# KERNEL: Output = 0001
# KERNEL: Output = 1000
# KERNEL: Output = 0100
# KERNEL: Output = 0010
# KERNEL: Output = 0001
