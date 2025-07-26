module Neuron_204 #(parameter DATA_WIDTH = 8, parameter FRAC_BITS = 4)(
	input logic clk,
	input logic En,
	input logic rst,
	input logic Run,
	input logic signed[DATA_WIDTH-1:0] X1,
	input logic signed[DATA_WIDTH-1:0] X2,
	input logic signed[DATA_WIDTH-1:0] X3,
	input logic signed[DATA_WIDTH-1:0] X4,
	input logic signed[DATA_WIDTH-1:0] X5,
	input logic signed[DATA_WIDTH-1:0] X6,
	output logic signed [DATA_WIDTH-1:0] Y
	);

	logic signed [DATA_WIDTH-1:0] XR1;
	logic signed [DATA_WIDTH-1:0] XR2;
	logic signed [DATA_WIDTH-1:0] XR3;
	logic signed [DATA_WIDTH-1:0] XR4;
	logic signed [DATA_WIDTH-1:0] XR5;
	logic signed [DATA_WIDTH-1:0] XR6;
	logic signed [2*DATA_WIDTH-1:0] M1b;
	logic signed [2*DATA_WIDTH-1:0] M2b;
	logic signed [2*DATA_WIDTH-1:0] M3b;
	logic signed [2*DATA_WIDTH-1:0] M4b;
	logic signed [2*DATA_WIDTH-1:0] M5b;
	logic signed [2*DATA_WIDTH-1:0] M6b;
	logic signed [2*DATA_WIDTH-1:0] M1;
	logic signed [2*DATA_WIDTH-1:0] M2;
	logic signed [2*DATA_WIDTH-1:0] M3;
	logic signed [2*DATA_WIDTH-1:0] M4;
	logic signed [2*DATA_WIDTH-1:0] M5;
	logic signed [2*DATA_WIDTH-1:0] M6;
	logic signed [DATA_WIDTH+5:0] ACC = -2;
	logic signed [DATA_WIDTH-1:0] Yb;
	parameter signed [DATA_WIDTH-1:0] W1 = 5;
	parameter signed [DATA_WIDTH-1:0] W2 = -11;
	parameter signed [DATA_WIDTH-1:0] W3 = -2;
	parameter signed [DATA_WIDTH-1:0] W4 = -3;
	parameter signed [DATA_WIDTH-1:0] W5 = 4;
	parameter signed [DATA_WIDTH-1:0] W6 = -7;
	parameter FLUSH_PIPELINE = 4'b0111;
	parameter BYPASS_INPUTS = 4'b1000;
	parameter IDLE = 4'b0000;
	parameter LOAD_INPUTS = 4'b0001;
	parameter MULTIPLY = 4'b0010;
	parameter SHIFTING = 4'b0011;
	parameter ADD  = 4'b0100;
	parameter ACTIVATION_FUNCTION = 4'b101;
	parameter RESULT = 4'b0110;

	reg[3:0] Neuron_State = FLUSH_PIPELINE;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			Neuron_State <= FLUSH_PIPELINE;
		end else if (En) begin
			case (Neuron_State)
				FLUSH_PIPELINE: begin
					if (Run)
						Neuron_State <= BYPASS_INPUTS;
					else
						Neuron_State <= FLUSH_PIPELINE;
				end
				IDLE: begin
					if (Run)
						Neuron_State <= LOAD_INPUTS;
					else
						Neuron_State <= FLUSH_PIPELINE;
				end
				LOAD_INPUTS: begin
					Neuron_State <= MULTIPLY;
				end
				BYPASS_INPUTS: begin
					Neuron_State <= MULTIPLY;
				end
				MULTIPLY: begin
					Neuron_State <= SHIFTING;
				end
				SHIFTING: begin
					Neuron_State <= ADD;
				end
				ADD: begin
					Neuron_State <= ACTIVATION_FUNCTION;
				end
				ACTIVATION_FUNCTION: begin
					Neuron_State <= RESULT;
				end
				RESULT: begin
					Neuron_State <= IDLE;
				end
				default: begin
					Neuron_State <= FLUSH_PIPELINE;
				end
			endcase
		end
	end

	always @(posedge clk) begin
		case (Neuron_State)
			FLUSH_PIPELINE: begin
				XR1 <= 0;
				XR2 <= 0;
				XR3 <= 0;
				XR4 <= 0;
				XR5 <= 0;
				XR6 <= 0;
				M1b <= 0;
				M2b <= 0;
				M3b <= 0;
				M4b <= 0;
				M5b <= 0;
				M6b <= 0;
				M1 <= 0;
				M2 <= 0;
				M3 <= 0;
				M4 <= 0;
				M5 <= 0;
				M6 <= 0;
			end
			LOAD_INPUTS: begin
				XR1 <= X1;
				XR2 <= X2;
				XR3 <= X3;
				XR4 <= X4;
				XR5 <= X5;
				XR6 <= X6;
				ACC <= -2;
				Yb <= 0;
			end
			BYPASS_INPUTS: begin
				XR1 <= 0;
				XR2 <= 0;
				XR3 <= 0;
				XR4 <= 0;
				XR5 <= 0;
				XR6 <= 0;
				ACC <= -2;
				Yb <= 0;
			end
			MULTIPLY: begin
				M1b <= XR1*W1;
				M2b <= XR2*W2;
				M3b <= XR3*W3;
				M4b <= XR4*W4;
				M5b <= XR5*W5;
				M6b <= XR6*W6;
			end
			SHIFTING: begin
				M1 <= M1b >>> FRAC_BITS;
				M2 <= M2b >>> FRAC_BITS;
				M3 <= M3b >>> FRAC_BITS;
				M4 <= M4b >>> FRAC_BITS;
				M5 <= M5b >>> FRAC_BITS;
				M6 <= M6b >>> FRAC_BITS;
			end
			ADD: begin
				ACC <= ACC + $signed(M1[DATA_WIDTH-1:0]) + $signed(M2[DATA_WIDTH-1:0]) + $signed(M3[DATA_WIDTH-1:0]) + $signed(M4[DATA_WIDTH-1:0]) + $signed(M5[DATA_WIDTH-1:0]) + $signed(M6[DATA_WIDTH-1:0]);
			end
			ACTIVATION_FUNCTION: begin
			//ReLU
				if (ACC > 0)
					Yb <= $signed(ACC[DATA_WIDTH-1:0]);
				else
					Yb <= 0;
			end
			RESULT: begin
				Y <= Yb;
			end
			default: begin
				XR1 <= XR1;
				XR2 <= XR2;
				XR3 <= XR3;
				XR4 <= XR4;
				XR5 <= XR5;
				XR6 <= XR6;
				M1b <= M1b;
				M2b <= M2b;
				M3b <= M3b;
				M4b <= M4b;
				M5b <= M5b;
				M6b <= M6b;
				M1 <= M1;
				M2 <= M2;
				M3 <= M3;
				M4 <= M4;
				M5 <= M5;
				M6 <= M6;
				ACC <= -2;
				Yb <= 0;
			end
		endcase
	end
endmodule