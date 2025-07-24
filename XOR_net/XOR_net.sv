module XOR_net #(parameter DATA_WIDTH = 8)(
	input logic clk,
	input logic En,
	input logic rst,
	input logic Run,
	input logic [DATA_WIDTH-1:0] X1,
	input logic [DATA_WIDTH-1:0] X2,
	output logic [DATA_WIDTH-1:0] Y1,
	output logic [1:0] Ready_Bus
	);

	logic READY_L1;
	logic READY_L2;
	logic [DATA_WIDTH-1:0] N1L1_OUT;
	logic [DATA_WIDTH-1:0] N2L1_OUT;
	logic [DATA_WIDTH-1:0] N3L1_OUT;
	logic [DATA_WIDTH-1:0] N4L1_OUT;
	logic [DATA_WIDTH-1:0] N1L2_OUT;
	Neuron_101 #(.DATA_WIDTH(DATA_WIDTH)) N1L1_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N1L1_OUT),
		.X1(X1),
		.X2(X2),
		.Ready(READY_L1)
	);

	Neuron_102 #(.DATA_WIDTH(DATA_WIDTH)) N2L1_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N2L1_OUT),
		.X1(X1),
		.X2(X2)
	);

	Neuron_103 #(.DATA_WIDTH(DATA_WIDTH)) N3L1_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N3L1_OUT),
		.X1(X1),
		.X2(X2)
	);

	Neuron_104 #(.DATA_WIDTH(DATA_WIDTH)) N4L1_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N4L1_OUT),
		.X1(X1),
		.X2(X2)
	);

	Neuron_201 #(.DATA_WIDTH(DATA_WIDTH)) N1L2_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(Y1),
		.X1(N1L1_OUT),
		.X2(N2L1_OUT),
		.X3(N3L1_OUT),
		.X4(N4L1_OUT),
		.Ready(READY_L2)
	);

	assign Ready_Bus = {READY_L2, READY_L1};
endmodule
