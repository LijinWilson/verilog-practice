`timescale 1ns / 1ps
    module binarytoBCD(i, y);
    input [7:0] i;
    output [11:0] y;
    
    reg [3:0] hundred, tens, ones;
    reg [6:0] temp_reg;
    
    always @ (*) begin
        hundred=i/100;
        temp_reg=i%100;
        
        tens=temp_reg/10;
        ones=temp_reg%10;
        
    end
    
    assign y = {hundred, tens, ones};
    
    
    endmodule
    
    
    // test bench
    //    ------------------ test bench ----------------
module tb();
reg [7:0] i;
wire [11:0]y;

// instantiating
binarytoBCD tt(i, y);

initial
    begin
        i=51; #2;
        $finish();
    end
    
    initial
        begin
            $monitor("i=%b | i=%d | y=%b | y=%d", i, i, y, y);
        end

endmodule
    
    

