module	multi_booth_8bit (p, rdy, clk, reset, a, b);
   input clk, reset;
   input [7:0] a, b;
   output reg [15:0] p;
   output reg rdy;
   
   reg [15:0] multiplier;
   reg [15:0] multiplicand;
   reg [4:0] ctr;

always @(posedge clk or posedge reset) begin
    if (reset) 
    begin
    rdy     <= 0;
    p       <= 0;
    ctr     <= 0;
    multiplier <= {a, 8'b0};
    multiplicand <= {b, 8'b0};
    end 
    else 
    begin 
      if(ctr < 16) 
          begin
          multiplicand <= multiplicand << 1;
            if (multiplier[ctr] == 1)
            begin
                p <= p + multiplicand;
            end
            ctr <= ctr + 1;
          end
       else 
           begin
           rdy <= 1;
           end
    end
  end //End of always block
    
endmodule
