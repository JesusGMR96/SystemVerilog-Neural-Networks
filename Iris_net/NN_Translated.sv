module NN_Translated #(parameter DATA_WIDTH = 8)(
	input logic clk,
	input logic En,
	input logic rst,
	input logic Run,
	input logic [DATA_WIDTH-1:0] X1,
	input logic [DATA_WIDTH-1:0] X2,
	input logic [DATA_WIDTH-1:0] X3,
	input logic [DATA_WIDTH-1:0] X4,
	output logic [DATA_WIDTH+5:0] Y1,
	output logic [DATA_WIDTH+5:0] Y2,
	output logic [DATA_WIDTH+5:0] Y3,
	output logic [2:0] Ready_Bus
	);

	logic READY_L1;
	logic READY_L2;
	logic READY_L3;
	logic [DATA_WIDTH-1:0] N1L1_OUT;
	logic [DATA_WIDTH-1:0] N2L1_OUT;
	logic [DATA_WIDTH-1:0] N3L1_OUT;
	logic [DATA_WIDTH-1:0] N4L1_OUT;
	logic [DATA_WIDTH-1:0] N5L1_OUT;
	logic [DATA_WIDTH-1:0] N6L1_OUT;
	logic [DATA_WIDTH-1:0] N1L2_OUT;
	logic [DATA_WIDTH-1:0] N2L2_OUT;
	logic [DATA_WIDTH-1:0] N3L2_OUT;
	logic [DATA_WIDTH-1:0] N4L2_OUT;
	logic [DATA_WIDTH-1:0] N5L2_OUT;
	logic [DATA_WIDTH-1:0] N6L2_OUT;
	logic [DATA_WIDTH-1:0] N1L3_OUT;
	logic [DATA_WIDTH-1:0] N2L3_OUT;
	logic [DATA_WIDTH-1:0] N3L3_OUT;
	Neuron_101 #(.DATA_WIDTH(DATA_WIDTH)) N1L1_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N1L1_OUT),
		.X1(X1),
		.X2(X2),
		.X3(X3),
		.X4(X4),
		.Ready(READY_L1)
	);

	Neuron_102 #(.DATA_WIDTH(DATA_WIDTH)) N2L1_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N2L1_OUT),
		.X1(X1),
		.X2(X2),
		.X3(X3),
		.X4(X4)
	);

	Neuron_103 #(.DATA_WIDTH(DATA_WIDTH)) N3L1_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N3L1_OUT),
		.X1(X1),
		.X2(X2),
		.X3(X3),
		.X4(X4)
	);

	Neuron_104 #(.DATA_WIDTH(DATA_WIDTH)) N4L1_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N4L1_OUT),
		.X1(X1),
		.X2(X2),
		.X3(X3),
		.X4(X4)
	);

	Neuron_105 #(.DATA_WIDTH(DATA_WIDTH)) N5L1_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N5L1_OUT),
		.X1(X1),
		.X2(X2),
		.X3(X3),
		.X4(X4)
	);

	Neuron_106 #(.DATA_WIDTH(DATA_WIDTH)) N6L1_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N6L1_OUT),
		.X1(X1),
		.X2(X2),
		.X3(X3),
		.X4(X4)
	);

	Neuron_201 #(.DATA_WIDTH(DATA_WIDTH)) N1L2_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N1L2_OUT),
		.X1(N1L1_OUT),
		.X2(N2L1_OUT),
		.X3(N3L1_OUT),
		.X4(N4L1_OUT),
		.X5(N5L1_OUT),
		.X6(N6L1_OUT),
		.Ready(READY_L2)
	);

	Neuron_202 #(.DATA_WIDTH(DATA_WIDTH)) N2L2_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N2L2_OUT),
		.X1(N1L1_OUT),
		.X2(N2L1_OUT),
		.X3(N3L1_OUT),
		.X4(N4L1_OUT),
		.X5(N5L1_OUT),
		.X6(N6L1_OUT)
	);

	Neuron_203 #(.DATA_WIDTH(DATA_WIDTH)) N3L2_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N3L2_OUT),
		.X1(N1L1_OUT),
		.X2(N2L1_OUT),
		.X3(N3L1_OUT),
		.X4(N4L1_OUT),
		.X5(N5L1_OUT),
		.X6(N6L1_OUT)
	);

	Neuron_204 #(.DATA_WIDTH(DATA_WIDTH)) N4L2_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N4L2_OUT),
		.X1(N1L1_OUT),
		.X2(N2L1_OUT),
		.X3(N3L1_OUT),
		.X4(N4L1_OUT),
		.X5(N5L1_OUT),
		.X6(N6L1_OUT)
	);

	Neuron_205 #(.DATA_WIDTH(DATA_WIDTH)) N5L2_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N5L2_OUT),
		.X1(N1L1_OUT),
		.X2(N2L1_OUT),
		.X3(N3L1_OUT),
		.X4(N4L1_OUT),
		.X5(N5L1_OUT),
		.X6(N6L1_OUT)
	);

	Neuron_206 #(.DATA_WIDTH(DATA_WIDTH)) N6L2_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(N6L2_OUT),
		.X1(N1L1_OUT),
		.X2(N2L1_OUT),
		.X3(N3L1_OUT),
		.X4(N4L1_OUT),
		.X5(N5L1_OUT),
		.X6(N6L1_OUT)
	);

	Neuron_301 #(.DATA_WIDTH(DATA_WIDTH)) N1L3_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(Y1),
		.X1(N1L2_OUT),
		.X2(N2L2_OUT),
		.X3(N3L2_OUT),
		.X4(N4L2_OUT),
		.X5(N5L2_OUT),
		.X6(N6L2_OUT),
		.Ready(READY_L3)
	);

	Neuron_302 #(.DATA_WIDTH(DATA_WIDTH)) N2L3_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(Y2),
		.X1(N1L2_OUT),
		.X2(N2L2_OUT),
		.X3(N3L2_OUT),
		.X4(N4L2_OUT),
		.X5(N5L2_OUT),
		.X6(N6L2_OUT)
	);

	Neuron_303 #(.DATA_WIDTH(DATA_WIDTH)) N3L3_inst(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.Y(Y3),
		.X1(N1L2_OUT),
		.X2(N2L2_OUT),
		.X3(N3L2_OUT),
		.X4(N4L2_OUT),
		.X5(N5L2_OUT),
		.X6(N6L2_OUT)
	);

	assign Ready_Bus = {READY_L3, READY_L2, READY_L1};
endmodule
