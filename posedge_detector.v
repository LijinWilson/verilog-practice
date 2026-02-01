// It will count/detect when the signal goes from o to 1 transition.
// It will only count the 0 -> 1 transition, not how long the siganl get stay for high

// -------------------------- DESIGN --------------------------
// Possitive Edge Detector
module posedge_detector(clk, sig, out);
  input clk, sig;
  output out;
  
  reg sig_dly;
  
  
  always @(posedge clk)
    begin
      sig_dly <= sig;
    end
  
  assign out = sig & ~sig_dly;
  
endmodule
// -------------------------- TESTBENCH --------------------------
module posedgeDetector_tb();
  reg clk, sig;
  wire out;
  
//   Instantiation
  posedge_detector tb1(clk, sig, out);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0, posedgeDetector_tb);
    end
  
  always #2 clk = ~clk;
  
  initial
    begin
      
      $monitor("Edge = %b", out);
      
      clk = 0;
      #5; sig <= 0;
      #5; sig <= 1;
      #5; sig <= 0;
      #5; sig <= 1;
      #5; sig <= 0;
      #10; sig <= 1;
      #10; $finish();
      
    end
  
endmodule
