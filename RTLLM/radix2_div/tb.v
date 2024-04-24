`timescale 1ns/1ps

module radix2_div_tb();

parameter DATAWIDTH = 8;
parameter TIME_LIMIT = 100;

reg  clk;
reg  rstn;       
reg  en;    
wire ready; 
wire vld_out;    
reg  [DATAWIDTH-1:0]    dividend; 
reg  [DATAWIDTH-1:0]    divisor;
wire [DATAWIDTH-1:0]    quotient;
wire [DATAWIDTH-1:0]    remainder;

verified_radix2_div #(
    .DATAWIDTH                     ( DATAWIDTH  ))
     u1(
            .clk                   ( clk        ),
            .rstn                  ( rstn       ),
            .en                    ( en         ),
            .ready                 ( ready      ),
            .dividend              ( dividend   ),
            .divisor               ( divisor    ),
            .quotient              ( quotient   ),
            .remainder             ( remainder  ),
            .vld_out               ( vld_out    )
);

always #1 clk = ~clk;

integer i;
integer error = 0;
reg [31:0] start_time;

reg  [DATAWIDTH-1:0]    num_a[0:39]; 
reg  [DATAWIDTH-1:0]    num_b[0:39];
reg  [DATAWIDTH-1:0]    expected_result[0:39];
reg  [DATAWIDTH-1:0]    expected_odd[0:39];

initial begin
  clk = 1;
  rstn = 1;
  en = 0;
  #2 rstn = 0; 
  #2 rstn = 1;
  repeat(2) @(posedge clk);

  for(i=0;i<40;i=i+1) begin
    en <= 1;
    dividend <= num_a[i];
    divisor <= num_b[i];
    start_time = $time;
    // Wait for the specified events or exceed the time limit
    repeat (TIME_LIMIT) begin
      if (($time - start_time) > TIME_LIMIT) begin
        $fatal("Error: Testbench exceeded time limit of %0t seconds", TIME_LIMIT);
      end
      if (ready == 1 && vld_out == 1) begin
        $display("Test Case %d - Dividend: %d, Divisor: %d, Quotient: %d, Remainder: %d", i + 1, dividend, divisor, quotient, remainder);
        error = (quotient != expected_result[i]) || (remainder != expected_odd[i]) ? error + 1 : error;
      end
      #1; // Advance time by 1 time unit
    end

    if (ready != 1 || vld_out != 1) begin
      $fatal("Error: Testbench exceeded time limit of %0t seconds", TIME_LIMIT);
    end
  end
  if (error == 0) begin
      $display("===========Your Design Passed===========");
    end
    else begin
    $display("===========Failed===========", error);
    end

$finish;

end

initial begin
num_a[0] = 8'H79;
num_b[0] = 8'H82;
expected_result[0] = 8'H00;
expected_odd[0] = 8'H79;
num_a[1] = 8'H1B;
num_b[1] = 8'HAD;
expected_result[1] = 8'H00;
expected_odd[1] = 8'H1B;
num_a[2] = 8'HD2;
num_b[2] = 8'HC0;
expected_result[2] = 8'H01;
expected_odd[2] = 8'H12;
num_a[3] = 8'H06;
num_b[3] = 8'H0C;
expected_result[3] = 8'H00;
expected_odd[3] = 8'H06;
num_a[4] = 8'HB9;
num_b[4] = 8'HBE;
expected_result[4] = 8'H00;
expected_odd[4] = 8'HB9;
num_a[5] = 8'HF5;
num_b[5] = 8'H8C;
expected_result[5] = 8'H01;
expected_odd[5] = 8'H69;
num_a[6] = 8'HB3;
num_b[6] = 8'HB6;
expected_result[6] = 8'H00;
expected_odd[6] = 8'HB3;
num_a[7] = 8'H5F;
num_b[7] = 8'HD5;
expected_result[7] = 8'H00;
expected_odd[7] = 8'H5F;
num_a[8] = 8'H7C;
num_b[8] = 8'H59;
expected_result[8] = 8'H01;
expected_odd[8] = 8'H23;
num_a[9] = 8'H89;
num_b[9] = 8'H44;
expected_result[9] = 8'H02;
expected_odd[9] = 8'H01;
num_a[10] = 8'HA2;
num_b[10] = 8'H6E;
expected_result[10] = 8'H01;
expected_odd[10] = 8'H34;
num_a[11] = 8'H82;
num_b[11] = 8'HD5;
expected_result[11] = 8'H00;
expected_odd[11] = 8'H82;
num_a[12] = 8'H63;
num_b[12] = 8'HAD;
expected_result[12] = 8'H00;
expected_odd[12] = 8'H63;
num_a[13] = 8'H66;
num_b[13] = 8'HE9;
expected_result[13] = 8'H00;
expected_odd[13] = 8'H66;
num_a[14] = 8'HE6;
num_b[14] = 8'H0C;
expected_result[14] = 8'H13;
expected_odd[14] = 8'H02;
num_a[15] = 8'H8F;
num_b[15] = 8'H4A;
expected_result[15] = 8'H01;
expected_odd[15] = 8'H45;
num_a[16] = 8'HBE;
num_b[16] = 8'H42;
expected_result[16] = 8'H02;
expected_odd[16] = 8'H3A;
num_a[17] = 8'H25;
num_b[17] = 8'HB0;
expected_result[17] = 8'H00;
expected_odd[17] = 8'H25;
num_a[18] = 8'HA6;
num_b[18] = 8'H37;
expected_result[18] = 8'H03;
expected_odd[18] = 8'H01;
num_a[19] = 8'HE4;
num_b[19] = 8'H10;
expected_result[19] = 8'H0E;
expected_odd[19] = 8'H04;
num_a[20] = 8'H29;
num_b[20] = 8'HC9;
expected_result[20] = 8'H00;
expected_odd[20] = 8'H29;
num_a[21] = 8'HB9;
num_b[21] = 8'H33;
expected_result[21] = 8'H03;
expected_odd[21] = 8'H20;
num_a[22] = 8'H0C;
num_b[22] = 8'H01;
expected_result[22] = 8'H0C;
expected_odd[22] = 8'H00;
num_a[23] = 8'H32;
num_b[23] = 8'H5F;
expected_result[23] = 8'H00;
expected_odd[23] = 8'H32;
num_a[24] = 8'H5C;
num_b[24] = 8'HEA;
expected_result[24] = 8'H00;
expected_odd[24] = 8'H5C;
num_a[25] = 8'HE7;
num_b[25] = 8'HCC;
expected_result[25] = 8'H01;
expected_odd[25] = 8'H1B;
num_a[26] = 8'H8B;
num_b[26] = 8'H7A;
expected_result[26] = 8'H01;
expected_odd[26] = 8'H11;
num_a[27] = 8'H1A;
num_b[27] = 8'H07;
expected_result[27] = 8'H03;
expected_odd[27] = 8'H05;
num_a[28] = 8'HF6;
num_b[28] = 8'HA2;
expected_result[28] = 8'H01;
expected_odd[28] = 8'H54;
num_a[29] = 8'H48;
num_b[29] = 8'H52;
expected_result[29] = 8'H00;
expected_odd[29] = 8'H48;
num_a[30] = 8'H96;
num_b[30] = 8'H47;
expected_result[30] = 8'H02;
expected_odd[30] = 8'H08;
num_a[31] = 8'H66;
num_b[31] = 8'HF6;
expected_result[31] = 8'H00;
expected_odd[31] = 8'H66;
num_a[32] = 8'HE0;
num_b[32] = 8'H5D;
expected_result[32] = 8'H02;
expected_odd[32] = 8'H26;
num_a[33] = 8'H2C;
num_b[33] = 8'H16;
expected_result[33] = 8'H02;
expected_odd[33] = 8'H00;
num_a[34] = 8'H78;
num_b[34] = 8'H2D;
expected_result[34] = 8'H02;
expected_odd[34] = 8'H1E;
num_a[35] = 8'H73;
num_b[35] = 8'HAD;
expected_result[35] = 8'H00;
expected_odd[35] = 8'H73;
num_a[36] = 8'H13;
num_b[36] = 8'H57;
expected_result[36] = 8'H00;
expected_odd[36] = 8'H13;
num_a[37] = 8'H0A;
num_b[37] = 8'HC1;
expected_result[37] = 8'H00;
expected_odd[37] = 8'H0A;
num_a[38] = 8'H9F;
num_b[38] = 8'HAE;
expected_result[38] = 8'H00;
expected_odd[38] = 8'H9F;
num_a[39] = 8'HC0;
num_b[39] = 8'H46;
expected_result[39] = 8'H02;
expected_odd[39] = 8'H34;
  
end

endmodule

