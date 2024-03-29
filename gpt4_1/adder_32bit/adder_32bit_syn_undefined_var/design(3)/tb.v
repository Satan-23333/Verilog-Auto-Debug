`timescale  1ns/1ns
module tb;
  
  reg [31:0] A;
  reg [31:0] B;
  wire [31:0] S;
  wire C32;
  
  integer i; 
  integer error = 0; 
  
  // Instantiate the module
  adder_32bit uut (
    .A(A), 
    .B(B), 
    .S(S), 
    .C32(C32)
  );
  reg [31:0]num_a[0:39];
  reg [31:0]num_b[0:39];
  reg [32:0]result[0:39];
    // Randomize inputs and check output
  initial begin
    for (i = 0; i < 40; i = i + 1) begin
      A = num_a[i];
      B = num_b[i];
      #10; 
      // Calculate expected sum and carry out
      error = ({C32,S}!==result[i]) ? error+1 : error;
      if(error!=0)begin
        $display("This is testbench input: A=32'H%h, B=32'H%h, and expected_result=33'H%h, but the result is {C32,S}=33'H%h; please fix the error",num_a[i],num_b[i],result[i],{C32,S});
        $finish;
      end    
    end
    if (error == 0) begin
            $display("===========Your Design Passed===========");
    end
    else begin
    $display("===========Test completed with %d /40 failures===========", error);
    end
  end
  initial begin
num_a[0] = 32'HDA8FC6A1;
num_b[0] = 32'HEFCE4657;
result[0] = 33'H1CA5E0CF8;
num_a[1] = 32'H8FDAE6EB;
num_b[1] = 32'H5CCAC80E;
result[1] = 33'H0ECA5AEF9;
num_a[2] = 32'HEDA98C81;
num_b[2] = 32'H2D2F6A0E;
result[2] = 33'H11AD8F68F;
num_a[3] = 32'HB3E6EB88;
num_b[3] = 32'H4BF234BD;
result[3] = 33'H0FFD92045;
num_a[4] = 32'HEDC33064;
num_b[4] = 32'HA8E96644;
result[4] = 33'H196AC96A8;
num_a[5] = 32'HC0B1F9B8;
num_b[5] = 32'HC33357AF;
result[5] = 33'H183E55167;
num_a[6] = 32'H4C3E662D;
num_b[6] = 32'H06906BB1;
result[6] = 33'H052CED1DE;
num_a[7] = 32'H0CBC8346;
num_b[7] = 32'H486A417F;
result[7] = 33'H05526C4C5;
num_a[8] = 32'HD8379621;
num_b[8] = 32'H72AB1792;
result[8] = 33'H14AE2ADB3;
num_a[9] = 32'HEDEABC61;
num_b[9] = 32'HBA3137F6;
result[9] = 33'H1A81BF457;
num_a[10] = 32'HAA4B89D9;
num_b[10] = 32'H465D8E89;
result[10] = 33'H0F0A91862;
num_a[11] = 32'H79B6B710;
num_b[11] = 32'HCDCC9685;
result[11] = 33'H147834D95;
num_a[12] = 32'H9FC140EB;
num_b[12] = 32'H47E838DE;
result[12] = 33'H0E7A979C9;
num_a[13] = 32'H9CE263D1;
num_b[13] = 32'H9CA8CE72;
result[13] = 33'H1398B3243;
num_a[14] = 32'H1C4D03A1;
num_b[14] = 32'H3AFB9299;
result[14] = 33'H05748963A;
num_a[15] = 32'H1C143E00;
num_b[15] = 32'H968F377D;
result[15] = 33'H0B2A3757D;
num_a[16] = 32'H0704E01F;
num_b[16] = 32'HFD8C9775;
result[16] = 33'H104917794;
num_a[17] = 32'HD970688C;
num_b[17] = 32'H909F43D0;
result[17] = 33'H16A0FAC5C;
num_a[18] = 32'HC2050495;
num_b[18] = 32'HFE75586C;
result[18] = 33'H1C07A5D01;
num_a[19] = 32'H509D2C4F;
num_b[19] = 32'H1B51AAE2;
result[19] = 33'H06BEED731;
num_a[20] = 32'H5869E6A8;
num_b[20] = 32'H1467EFEF;
result[20] = 33'H06CD1D697;
num_a[21] = 32'H3AFEB614;
num_b[21] = 32'HC1D6C332;
result[21] = 33'H0FCD57946;
num_a[22] = 32'H079B7395;
num_b[22] = 32'H44B20986;
result[22] = 33'H04C4D7D1B;
num_a[23] = 32'H137EE986;
num_b[23] = 32'HC4AF3713;
result[23] = 33'H0D82E2099;
num_a[24] = 32'HADD07EC9;
num_b[24] = 32'H302DC759;
result[24] = 33'H0DDFE4622;
num_a[25] = 32'HDAF1A17E;
num_b[25] = 32'HC110BED4;
result[25] = 33'H19C026052;
num_a[26] = 32'H90A88B76;
num_b[26] = 32'HC4DF734E;
result[26] = 33'H15587FEC4;
num_a[27] = 32'H31444B97;
num_b[27] = 32'H09747871;
result[27] = 33'H03AB8C408;
num_a[28] = 32'H0B4230A9;
num_b[28] = 32'HD409BDA9;
result[28] = 33'H0DF4BEE52;
num_a[29] = 32'H3AC20324;
num_b[29] = 32'H94C9BA2B;
result[29] = 33'H0CF8BBD4F;
num_a[30] = 32'HF62830ED;
num_b[30] = 32'H659DDFD3;
result[30] = 33'H15BC610C0;
num_a[31] = 32'H0CE9FCE9;
num_b[31] = 32'HDFCC41F9;
result[31] = 33'H0ECB63EE2;
num_a[32] = 32'HDC1C516F;
num_b[32] = 32'HEFBB0535;
result[32] = 33'H1CBD756A4;
num_a[33] = 32'HE703F9C3;
num_b[33] = 32'HAF1FFABA;
result[33] = 33'H19623F47D;
num_a[34] = 32'HD350FEB1;
num_b[34] = 32'H36126564;
result[34] = 33'H109636415;
num_a[35] = 32'HF1991A84;
num_b[35] = 32'HFE130C12;
result[35] = 33'H1EFAC2696;
num_a[36] = 32'H09FDA1D1;
num_b[36] = 32'HBA39F933;
result[36] = 33'H0C4379B04;
num_a[37] = 32'HB154A018;
num_b[37] = 32'HA65AD622;
result[37] = 33'H157AF763A;
num_a[38] = 32'H9EED062B;
num_b[38] = 32'H64A77103;
result[38] = 33'H10394772E;
num_a[39] = 32'HD92E8878;
num_b[39] = 32'HA8759630;
result[39] = 33'H181A41EA8;
  
  end


endmodule