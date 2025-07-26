module Neuron_103 #(parameter DATA_WIDTH = 8, parameter FRAC_BITS = 4)(
	input logic clk,
	input logic En,
	input logic rst,
	input logic Run,
	input logic signed[DATA_WIDTH-1:0] X1,
	input logic signed[DATA_WIDTH-1:0] X2,
	input logic signed[DATA_WIDTH-1:0] X3,
	input logic signed[DATA_WIDTH-1:0] X4,
	output logic signed [DATA_WIDTH-1:0] Y
	);

	logic signed [DATA_WIDTH-1:0] XR1;
	logic signed [DATA_WIDTH-1:0] XR2;
	logic signed [DATA_WIDTH-1:0] XR3;
	logic signed [DATA_WIDTH-1:0] XR4;
	logic signed [2*DATA_WIDTH-1:0] M1b;
	logic signed [2*DATA_WIDTH-1:0] M2b;
	logic signed [2*DATA_WIDTH-1:0] M3b;
	logic signed [2*DATA_WIDTH-1:0] M4b;
	logic signed [2*DATA_WIDTH-1:0] M1;
	logic signed [2*DATA_WIDTH-1:0] M2;
	logic signed [2*DATA_WIDTH-1:0] M3;
	logic signed [2*DATA_WIDTH-1:0] M4;
	logic signed [DATA_WIDTH+3:0] ACC = -5;
	logic signed [DATA_WIDTH-1:0] Yb;
	parameter signed [DATA_WIDTH-1:0] W1 = 5;
	parameter signed [DATA_WIDTH-1:0] W2 = -5;
	parameter signed [DATA_WIDTH-1:0] W3 = 12;
	parameter signed [DATA_WIDTH-1:0] W4 = 14;
	parameter IDLE = 3'b000;
	parameter LOAD_INPUTS = 3'b001;
	parameter MULTIPLY = 3'b010;
	parameter SHIFTING = 3'b011;
	parameter ADD  = 3'b100;
	parameter ACTIVATION_FUNCTION = 3'b101;
	parameter RESULT = 3'b110;

	reg[2:0] Neuron_State = IDLE;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
			Neuron_State <= IDLE;
		end else if (En) begin
			case (Neuron_State)
				IDLE: begin
					if (Run)
						Neuron_State <= LOAD_INPUTS;
					else
						Neuron_State <= IDLE;
				end
				LOAD_INPUTS: begin
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
					Neuron_State <= IDLE;
				end
			endcase
		end
	end

	always @(posedge clk) begin
		case (Neuron_State)
			LOAD_INPUTS: begin
				XR1 <= X1;
				XR2 <= X2;
				XR3 <= X3;
				XR4 <= X4;
				ACC <= -5;
				Yb <= 0;
			end
			MULTIPLY: begin
				M1b <= XR1*W1;
				M2b <= XR2*W2;
				M3b <= XR3*W3;
				M4b <= XR4*W4;
			end
			SHIFTING: begin
				M1 <= M1b >>> FRAC_BITS;
				M2 <= M2b >>> FRAC_BITS;
				M3 <= M3b >>> FRAC_BITS;
				M4 <= M4b >>> FRAC_BITS;
			end
			ADD: begin
				ACC <= ACC + $signed(M1[DATA_WIDTH-1:0]) + $signed(M2[DATA_WIDTH-1:0]) + $signed(M3[DATA_WIDTH-1:0]) + $signed(M4[DATA_WIDTH-1:0]);
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
				M1b <= M1b;
				M2b <= M2b;
				M3b <= M3b;
				M4b <= M4b;
				M1 <= M1;
				M2 <= M2;
				M3 <= M3;
				M4 <= M4;
				ACC <= -5;
				Yb <= 0;
			end
		endcase
	end
endmodule