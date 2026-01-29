// -------------------------- Design --------------------------

module JK_ff(j, k, clk, q);
  input j, k, clk;
  output reg q;
  
  wire q_bar;
  
  always @(posedge clk)
    begin
      case({j,k})
        2'b00: q <= q;
        2'b01: q <= 0;
        2'b10: q <= 1;
        2'b11: q <= ~q;
      endcase
    end
  
  assign q_bar = ~q;
  
endmodule

// -------------------------- Test bench --------------------------

module jk_tb();
  reg j, k, clk;
  wire q;
  
//   Instantiation
  JK_ff tb1(j, k, clk, q);
  
  initial
    begin
      $dumpfile("dump.vcd");
      $dumpvars(0, jk_tb);
    end
  
  initial
    begin
      clk = 0;
      j = 0; k = 0;
      #5; j = 0; k = 1;
      #5; j = 1; k = 0;
      #5; j = 1; k = 1;
      #5; $finish();
    end
  
  always #2 clk = ~clk;
  
  initial
    begin
      $monitor("J = %b | K = %b | Q = %b |", j, k, q);
    end
  
endmodule
