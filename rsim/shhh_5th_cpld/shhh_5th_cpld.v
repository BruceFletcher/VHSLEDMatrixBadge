module shhh_5th_cpld(
	input in_row_clk,
	input in_row_data,
	input [3:0] in_column,
	input [4:0] in_button,
	output reg [15:0] out_row,
	output [15:0] out_column,
	output [2:0] out_button
);

initial
begin
	out_row = 16'b0;
end


//always @(posedge in_row_clk) out_row <= (out_row << 1'b1) | {15'b0, ~in_row_data};
always @(posedge in_row_clk) out_row <= (out_row << {15'b0, 1'b1}) | {15'b0, in_row_data};


/*always @(in_column)
begin
	//out_column <= 16'b0Z << in_column;
	out_column <= 16'b01 << in_column;
end*/
//assign out_column = 16'b0Z << in_column;
//assign out_column = 16'b01 << in_column;
//assign out_column = { 12'b0Z, in_column };
assign out_column = (in_column == 0) ?
	16'bZZZZZZZZZZZZZZZ0 :
	((in_column == 1) ?
		16'bZZZZZZZZZZZZZZ0Z :
		((in_column == 2) ?
			16'bZZZZZZZZZZZZZ0ZZ :
			((in_column == 3) ?
				16'bZZZZZZZZZZZZ0ZZZ :
				((in_column == 4) ?
					16'bZZZZZZZZZZZ0ZZZZ :
					((in_column == 5) ?
						16'bZZZZZZZZZZ0ZZZZZ :
						((in_column == 6) ?
							16'bZZZZZZZZZ0ZZZZZZ :
							((in_column == 7) ?
								16'bZZZZZZZZ0ZZZZZZZ :
								((in_column == 8) ?
									16'bZZZZZZZ0ZZZZZZZZ :
									((in_column == 9) ?
										16'bZZZZZZ0ZZZZZZZZZ :
										((in_column == 10) ?
											16'bZZZZZ0ZZZZZZZZZZ :
											((in_column == 11) ?
												16'bZZZZ0ZZZZZZZZZZZ :
												((in_column == 12) ?
													16'bZZZ0ZZZZZZZZZZZZ :
													((in_column == 13) ?
														16'bZZ0ZZZZZZZZZZZZZ :
														((in_column == 14) ?
															16'bZ0ZZZZZZZZZZZZZZ :
															16'b0ZZZZZZZZZZZZZZZ
														)
													)
												)
											)
										)
									)
								)
							)
						)
					)
				)
			)
		)
	);


assign out_button = (!in_button[0] && !in_button[1]) ?
	3'd1 :
	((!in_button[0] && !in_button[2]) ?
		3'd2 :
		((!in_button[0] && !in_button[3]) ?
			3'd3 :
			((!in_button[1] && !in_button[2]) ?
				3'd4 :
				((!in_button[1] && !in_button[3]) ?
					3'd5 :
					((!in_button[2] && !in_button[3]) ?
						3'd6 :
						((!in_button[4]) ?
							3'd7 :
							3'd0))))));

endmodule
