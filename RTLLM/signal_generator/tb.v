module tb_signal_generator;
reg				clk,rst_n;
wire[4:0]		wave;

verified_signal_generator uut(
				.clk(clk),
				.rst_n(rst_n),
				.wave(wave)
				);

reg[4:0]data[0:99];

integer i = 0;
integer error = 0;
// integer outfile;
initial begin
			clk = 0;
      rst_n = 0;
			#10
      rst_n =1;
      // outfile = $fopen("tri_gen.txt", "w");
			repeat(100) begin
        // $fwrite(outfile, "%h\n", wave);
        // $display(wave);
        error=(wave==data[i])?error:error+1;
        #10;
        i = i+1;
      end
      // $fclose(outfile);
      if(error==0)
      begin
        $display("===========Your Design Passed===========");
            end
      else
      begin
        $display("===========Error===========");
      end
      $finish;
end
 
always #5 clk =~clk;
initial begin
data[0] = 5'b00000;
data[1] = 5'b00001;
data[2] = 5'b00010;
data[3] = 5'b00011;
data[4] = 5'b00100;
data[5] = 5'b00101;
data[6] = 5'b00110;
data[7] = 5'b00111;
data[8] = 5'b01000;
data[9] = 5'b01001;
data[10] = 5'b01010;
data[11] = 5'b01011;
data[12] = 5'b01100;
data[13] = 5'b01101;
data[14] = 5'b01110;
data[15] = 5'b01111;
data[16] = 5'b10000;
data[17] = 5'b10001;
data[18] = 5'b10010;
data[19] = 5'b10011;
data[20] = 5'b10100;
data[21] = 5'b10101;
data[22] = 5'b10110;
data[23] = 5'b10111;
data[24] = 5'b11000;
data[25] = 5'b11001;
data[26] = 5'b11010;
data[27] = 5'b11011;
data[28] = 5'b11100;
data[29] = 5'b11101;
data[30] = 5'b11110;
data[31] = 5'b11111;
data[32] = 5'b11111;
data[33] = 5'b11110;
data[34] = 5'b11101;
data[35] = 5'b11100;
data[36] = 5'b11011;
data[37] = 5'b11010;
data[38] = 5'b11001;
data[39] = 5'b11000;
data[40] = 5'b10111;
data[41] = 5'b10110;
data[42] = 5'b10101;
data[43] = 5'b10100;
data[44] = 5'b10011;
data[45] = 5'b10010;
data[46] = 5'b10001;
data[47] = 5'b10000;
data[48] = 5'b01111;
data[49] = 5'b01110;
data[50] = 5'b01101;
data[51] = 5'b01100;
data[52] = 5'b01011;
data[53] = 5'b01010;
data[54] = 5'b01001;
data[55] = 5'b01000;
data[56] = 5'b00111;
data[57] = 5'b00110;
data[58] = 5'b00101;
data[59] = 5'b00100;
data[60] = 5'b00011;
data[61] = 5'b00010;
data[62] = 5'b00001;
data[63] = 5'b00000;
data[64] = 5'b00000;
data[65] = 5'b00001;
data[66] = 5'b00010;
data[67] = 5'b00011;
data[68] = 5'b00100;
data[69] = 5'b00101;
data[70] = 5'b00110;
data[71] = 5'b00111;
data[72] = 5'b01000;
data[73] = 5'b01001;
data[74] = 5'b01010;
data[75] = 5'b01011;
data[76] = 5'b01100;
data[77] = 5'b01101;
data[78] = 5'b01110;
data[79] = 5'b01111;
data[80] = 5'b10000;
data[81] = 5'b10001;
data[82] = 5'b10010;
data[83] = 5'b10011;
data[84] = 5'b10100;
data[85] = 5'b10101;
data[86] = 5'b10110;
data[87] = 5'b10111;
data[88] = 5'b11000;
data[89] = 5'b11001;
data[90] = 5'b11010;
data[91] = 5'b11011;
data[92] = 5'b11100;
data[93] = 5'b11101;
data[94] = 5'b11110;
data[95] = 5'b11111;
data[96] = 5'b11111;
data[97] = 5'b11110;
data[98] = 5'b11101;
data[99] = 5'b11100;
end 
endmodule
