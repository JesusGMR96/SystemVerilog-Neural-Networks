module Iris_net #(parameter DATA_WIDTH = 8)(
	input logic clk,
	input logic En,
	input logic rst,
	input logic Run,
	input logic [DATA_WIDTH-1:0]  X1,
	input logic [DATA_WIDTH-1:0]  X2,
	input logic [DATA_WIDTH-1:0]  X3,
	input logic [DATA_WIDTH-1:0]  X4,
	output logic [1:0] Yc,
	output logic [3:0] Ready_NN_arg
	);
	logic signed [DATA_WIDTH+5:0] XS1;
	logic signed [DATA_WIDTH+5:0] XS2;
	logic signed [DATA_WIDTH+5:0] XS3;
	logic [2:0] Ready_Bus;
	logic Ready_arg;
	NN_Translated #(.DATA_WIDTH(DATA_WIDTH)) NN_inst1(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.X1(X1),
		.X2(X2),
		.X3(X3),
		.X4(X4),
		.Y1(XS1),
		.Y2(XS2),
		.Y3(XS3),
		.Ready_Bus(Ready_Bus)
	);

	arg_max #(.DATA_WIDTH(DATA_WIDTH)) Class_inst2(
		.clk(clk),
		.En(En),
		.rst(rst),
		.Run(Run),
		.XS1(XS1),
		.XS2(XS2),
		.XS3(XS3),
		.Yc(Yc),
		.Ready_arg(Ready_arg)
	);
	assign Ready_NN_arg = {Ready_arg, Ready_Bus};
endmodule
