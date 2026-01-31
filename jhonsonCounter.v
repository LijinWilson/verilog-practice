// In jhonson counter, inverted input of the last stage of FF is fedback to the input of first FF.
// ----------------------- DESIGN -----------------------
// Code your design here
module jhonson_counter(clk, rst, out);
  input clk, rst;
  output reg [3:0] out;
  
  always @(posedge clk or posedge rst)
    begin
      if(rst)
        begin
          out <= 0;
        end
      else
        begin
          out[3] <= ~out[0];
          for(int i = 0; i<3; i=i+1)
        		begin
          			out[i] <= out[i+1];
        		end	
        end
    end
  
endmodule
// ----------------------- TEST BENCH -----------------------
module jhonsonCounter_tb();
  reg clk, rst;
  wire [3:0] out;
  
//   Instantiation
  jhonson_counter tt1(clk, rst, out);
  
  initial
    begin
      $dumpfile("dump,vcd");
      $dumpvars(0, jhonsonCounter_tb);
    end
  
  always #2 clk = ~clk;
  
  initial
    begin
      
      $monitor("Output = %b", out);
      
      clk <= 0;
      rst <= 0;
      
      #5; rst <= 1;
      #5; rst <= 0;
      
      #50; $finish();
      
    end
  
endmodule
// ----------------------- OUTPUT -----------------------
# KERNEL: Output = 0000
# KERNEL: Output = 1000
# KERNEL: Output = 1100
# KERNEL: Output = 1110
# KERNEL: Output = 1111
# KERNEL: Output = 0111
# KERNEL: Output = 0011
# KERNEL: Output = 0001
# KERNEL: Output = 0000
