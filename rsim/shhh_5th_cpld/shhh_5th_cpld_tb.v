`timescale 1ns / 1ps

module shhh_5th_cpld_tb;

reg row_clk;
reg row_data;
reg[3:0] column;
reg[4:0] button;

reg[15:0] row_expected;
reg[15:0] column_expected;
reg[2:0] button_expected;

initial
begin
	row_expected = 16'b0000000000000000;
	row_clk = 1'b0;
	row_data = 1'b0;
	
	column = 4'b0;
	
	button = 5'b0;
	
	// ROW
	#50 row_expected = 16'b0000000000000001; row_data = 1'b1;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0000000000000010; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0000000000000101; row_data = 1'b1;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0000000000001010; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0000000000010100; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0000000000101001; row_data = 1'b1;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0000000001010011; row_data = 1'b1;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;

	#50 row_expected = 16'b0000000010100110; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0000000101001100; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0000001010011000; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0000010100110000; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0000101001100000; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0001010011000000; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0010100110000000; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0101001100000000; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b1010011000000000; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0100110000000000; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b1001100000000000; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0011000000000000; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0110000000000000; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b1100000000000000; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b1000000000000000; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	#50 row_expected = 16'b0000000000000000; row_data = 1'b0;
	#50 row_clk = 1'b1;
	#50 row_clk = 1'b0;
	
	// COLUMN
	#100 column = 4'b0001;
	#100 column = 4'b0010;
	#100 column = 4'b0011;
	#100 column = 4'b0100;
	#100 column = 4'b0111;
	#100 column = 4'b1000;
	#100 column = 4'b1110;
	#100 column = 4'b1111;
	#100 column = 4'b0000;
	#100 column = 4'b0001;
	
	// BUTTON
	#100 button_expected = 3'b000; button = 5'b11111;
	#100 button_expected = 3'b001; button = 5'b11100;
	#100 button_expected = 3'b010; button = 5'b11010;
	#100 button_expected = 3'b011; button = 5'b10110;
	#100 button_expected = 3'b100; button = 5'b11001;
	#100 button_expected = 3'b101; button = 5'b10101;
	#100 button_expected = 3'b110; button = 5'b10011;
	#100 button_expected = 3'b111; button = 5'b01111;
	
	#50 $finish;
end

wire [15:0] out_row;
wire [15:0] out_column;
wire [2:0] out_button;

// uut = Unit Under Test
shhh_5th_cpld uut(row_clk, row_data, column, button, out_row, out_column, out_button);

always @(negedge row_clk)
begin
	if (out_row != row_expected)
	begin
		$display("ERROR in signal out_row:");
		$displayb(out_row);
		$display("expected:");
		$displayb(row_expected);
	end
	else
	begin
		$display("Row PASSED");
	end
end

always @(column)
begin
	#50;
	//column_expected = 16'b01 << column;
	column_expected = 16'b0Z << column;
	
	if (column_expected !== out_column)
	begin
		$display("ERROR in signal out_column:");
		$displayb(out_column);
		$display("expected:");
		$displayb(column_expected);
		$display("column is:");
		$display(column);
	end
	else
	begin
		$display("Column PASSED");
	end
end

always @(button)
begin
	#50;
	if (button_expected != out_button)
	begin
		$display("ERROR in signal out_button:");
		$displayb(out_button);
		$display("expected:");
		$displayb(button_expected);
	end
	else
	begin
		$display("Button PASSED");
	end
end

endmodule
