// --------------------------- 3 BIT ASYNCHRONOUS UPCOUNTER ---------------------------
// In asynchronous up counter, clock we used in negative edge. which is mandatory.
// For storage here we using JK Flip Flop.

// --------------------------- Design ---------------------------
module jk_FF(clk, rst, j, k, q);
    input clk, rst, j, k;
    output reg q;

    always @(negedge clk or posedge rst) begin
      
      if(rst)
        begin
          q <= 0;
        end
      else 
        begin
          q <= (j&~q) | (~k&q);
        end
        
    end


endmodule

module upCounter_3bit(clk, rst, qa, qb, qc);
  input clk, rst;
  output qa, qb, qc;
  
//   instantiation jk FF three as counter is of 3 bit;
  jk_FF jk1(clk, rst, 1'b1, 1'b1, qa);
  jk_FF jk2(qa, rst, 1'b1, 1'b1, qb);
  jk_FF jk3(qb, rst, 1'b1, 1'b1, qc);
  
endmodule


// --------------------------- Test Bench ---------------------------

module counter_tb();
  reg clk, rst;
  wire qa, qb, qc;
  
//   Instantiate
  upCounter_3bit tb1(clk, rst, qa, qb, qc);
  
  initial
   begin
     clk = 0;
     rst = 1;
     
     #3; rst = 0;
   end
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0, counter_tb);
    end
  
  always #2 clk = ~clk;
  
  initial
    begin
      $monitor("QA = %0b | QB = %0b | QC = %0b | Decimal = %0d", qa, qb, qc, {qc, qb, qa});
      
      #60; $stop();
    end
  
endmodule
