// ------------------- design.v --------------------------------------

// Generate Case Statement
module half_adder(a, b, sum, carry);
  input a, b;
  output reg sum,carry;
  
  initial
    begin
      $display("Half adder instanttiation");
    end
  
  always @(a or b)
    begin
      {carry, sum} = a + b;
    end
  
endmodule

// Full Adder
module full_adder(a, b, cin, sum, carry);
  
  input a, b, cin;
  output reg sum, carry;
  
  initial
    $display("Full adder is instantiated");
  
  always @(a or b or cin)
    begin
      {carry, sum} = a + b + cin;
    end
endmodule

module adder(a, b, cin, sum, carry);
  input a, b, cin;
  output sum, carry;
  
  parameter adder_type = 0;
  
  generate
    case(adder_type)
      0: half_adder ha1(a, b, sum, carry);
      1: full_adder fa1(a, b, cin, sum, carry);
    endcase
  endgenerate
  
endmodule

// -------------------------------------------- Testbench.v --------------------------------------------
module adder_tb();
  reg a, b, cin;
  wire sum, carry;
  
// Instantiation
  adder #(.adder_type(0)) tb1(a, b, cin, sum, carry);
  
  initial
    begin
      a <= b <= cin <= 0;
      
      $monitor("a = %b | b = %b | cin = %b | sum = %b | carry = %b", a, b, cin, sum, carry);
      
//       assigning values
      for(int i = 0; i < 5; i = i + 1)
        begin
          #10;
          a <= $random;
          b <= $random;
          cin <= $random;
        end
    end
  
endmodule

// -------------------------------------------- Output --------------------------------------------
# KERNEL: a = x | b = x | cin = x | sum = x | carry = x
# KERNEL: a = 0 | b = 1 | cin = 1 | sum = 1 | carry = 0
# KERNEL: a = 1 | b = 1 | cin = 1 | sum = 0 | carry = 1
# KERNEL: a = 1 | b = 0 | cin = 1 | sum = 1 | carry = 0
