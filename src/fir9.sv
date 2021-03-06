module fir9( 
	input logic clk, 
	input logic rst, 
	input logic [3:0]x, 
	input logic [10:0]thresh, 
	input logic [3:0] c [8:0],
	output logic y
); 

logic [3:0] x_reg [0:8];
logic [3:0] c_reg [0:8];
logic [7:0] m_reg [0:8];
logic y_reg;
logic [10:0] thresh_reg;
logic [10:0] sum_reg;

always_ff@(posedge clk, posedge rst) begin

	if(rst)begin
		for (int tap = 0; tap < 9; tap++) begin
			x_reg[tap] <= 0;
			c_reg[tap] <= 0;
			m_reg[tap] <= 0;
		end

		thresh_reg <= 0;
		y<=0;
	end
       	
	else begin

		x_reg[0] <= x;
		c_reg[0] <= c[0];
		m_reg[0] <= x_reg[0]*c_reg[0];

		for (int tap = 1; tap < 9; tap++) begin
			x_reg[tap] <= x_reg[tap-1];
			c_reg[tap] <= c[tap];
			m_reg[tap] <= x_reg[tap]*c_reg[tap];
		end
	
		thresh_reg <= thresh;
		y <= y_reg;

	end
end

always_comb begin

	sum_reg = 0;

	for (int tap =0; tap < 9; tap++) begin

		sum_reg = sum_reg + m_reg[tap];

	end


	if (sum_reg < thresh_reg) 
		y_reg = 0;
	
	else 
		y_reg = 1;
	
end
		
endmodule
