module Neuron_201 #(parameter DATA_WIDTH = 8, parameter FRAC_BITS = 4)(
	input logic clk,
	input logic En,
	input logic rst,
	input logic Run,
	input logic signed[DATA_WIDTH-1:0] X1,
	input logic signed[DATA_WIDTH-1:0] X2,
	input logic signed[DATA_WIDTH-1:0] X3,
	input logic signed[DATA_WIDTH-1:0] X4,
	output logic signed [DATA_WIDTH-1:0] Y,
	output logic Ready
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
	logic signed [DATA_WIDTH+3:0] ACC = 0;
	logic signed [DATA_WIDTH-1:0] Yb;
	parameter signed [DATA_WIDTH-1:0] W1 = 49;
	parameter signed [DATA_WIDTH-1:0] W2 = 32;
	parameter signed [DATA_WIDTH-1:0] W3 = 92;
	parameter signed [DATA_WIDTH-1:0] W4 = -78;
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
				Ready <= 1'b0;
				XR1 <= 0;
				XR2 <= 0;
				XR3 <= 0;
				XR4 <= 0;
				M1b <= 0;
				M2b <= 0;
				M3b <= 0;
				M4b <= 0;
				M1 <= 0;
				M2 <= 0;
				M3 <= 0;
				M4 <= 0;
			end
			IDLE: begin
				XR1 <= 0;
				XR2 <= 0;
				XR3 <= 0;
				XR4 <= 0;
				M1b <= 0;
				M2b <= 0;
				M3b <= 0;
				M4b <= 0;
				M1 <= 0;
				M2 <= 0;
				M3 <= 0;
				M4 <= 0;
				Ready <= 1'b0;
			end
			LOAD_INPUTS: begin
				XR1 <= X1;
				XR2 <= X2;
				XR3 <= X3;
				XR4 <= X4;
				ACC <= 0;
				Yb <= 0;
			end
			BYPASS_INPUTS: begin
				XR1 <= 0;
				XR2 <= 0;
				XR3 <= 0;
				XR4 <= 0;
				ACC <= 0;
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
			//sigmoid
				case(ACC)
					-80:
						Yb <= 0;
					-79:
						Yb <= 0;
					-78:
						Yb <= 0;
					-77:
						Yb <= 0;
					-76:
						Yb <= 0;
					-75:
						Yb <= 0;
					-74:
						Yb <= 0;
					-73:
						Yb <= 0;
					-72:
						Yb <= 0;
					-71:
						Yb <= 0;
					-70:
						Yb <= 0;
					-69:
						Yb <= 0;
					-68:
						Yb <= 0;
					-67:
						Yb <= 0;
					-66:
						Yb <= 0;
					-65:
						Yb <= 0;
					-64:
						Yb <= 0;
					-63:
						Yb <= 0;
					-62:
						Yb <= 0;
					-61:
						Yb <= 0;
					-60:
						Yb <= 0;
					-59:
						Yb <= 0;
					-58:
						Yb <= 0;
					-57:
						Yb <= 0;
					-56:
						Yb <= 0;
					-55:
						Yb <= 0;
					-54:
						Yb <= 1;
					-53:
						Yb <= 1;
					-52:
						Yb <= 1;
					-51:
						Yb <= 1;
					-50:
						Yb <= 1;
					-49:
						Yb <= 1;
					-48:
						Yb <= 1;
					-47:
						Yb <= 1;
					-46:
						Yb <= 1;
					-45:
						Yb <= 1;
					-44:
						Yb <= 1;
					-43:
						Yb <= 1;
					-42:
						Yb <= 1;
					-41:
						Yb <= 1;
					-40:
						Yb <= 1;
					-39:
						Yb <= 1;
					-38:
						Yb <= 1;
					-37:
						Yb <= 1;
					-36:
						Yb <= 2;
					-35:
						Yb <= 2;
					-34:
						Yb <= 2;
					-33:
						Yb <= 2;
					-32:
						Yb <= 2;
					-31:
						Yb <= 2;
					-30:
						Yb <= 2;
					-29:
						Yb <= 2;
					-28:
						Yb <= 2;
					-27:
						Yb <= 2;
					-26:
						Yb <= 3;
					-25:
						Yb <= 3;
					-24:
						Yb <= 3;
					-23:
						Yb <= 3;
					-22:
						Yb <= 3;
					-21:
						Yb <= 3;
					-20:
						Yb <= 4;
					-19:
						Yb <= 4;
					-18:
						Yb <= 4;
					-17:
						Yb <= 4;
					-16:
						Yb <= 4;
					-15:
						Yb <= 5;
					-14:
						Yb <= 5;
					-13:
						Yb <= 5;
					-12:
						Yb <= 5;
					-11:
						Yb <= 5;
					-10:
						Yb <= 6;
					-9:
						Yb <= 6;
					-8:
						Yb <= 6;
					-7:
						Yb <= 6;
					-6:
						Yb <= 7;
					-5:
						Yb <= 7;
					-4:
						Yb <= 7;
					-3:
						Yb <= 7;
					-2:
						Yb <= 8;
					-1:
						Yb <= 8;
					0:
						Yb <= 8;
					1:
						Yb <= 8;
					2:
						Yb <= 8;
					3:
						Yb <= 9;
					4:
						Yb <= 9;
					5:
						Yb <= 9;
					6:
						Yb <= 9;
					7:
						Yb <= 10;
					8:
						Yb <= 10;
					9:
						Yb <= 10;
					10:
						Yb <= 10;
					11:
						Yb <= 11;
					12:
						Yb <= 11;
					13:
						Yb <= 11;
					14:
						Yb <= 11;
					15:
						Yb <= 11;
					16:
						Yb <= 12;
					17:
						Yb <= 12;
					18:
						Yb <= 12;
					19:
						Yb <= 12;
					20:
						Yb <= 12;
					21:
						Yb <= 13;
					22:
						Yb <= 13;
					23:
						Yb <= 13;
					24:
						Yb <= 13;
					25:
						Yb <= 13;
					26:
						Yb <= 13;
					27:
						Yb <= 14;
					28:
						Yb <= 14;
					29:
						Yb <= 14;
					30:
						Yb <= 14;
					31:
						Yb <= 14;
					32:
						Yb <= 14;
					33:
						Yb <= 14;
					34:
						Yb <= 14;
					35:
						Yb <= 14;
					36:
						Yb <= 14;
					37:
						Yb <= 15;
					38:
						Yb <= 15;
					39:
						Yb <= 15;
					40:
						Yb <= 15;
					41:
						Yb <= 15;
					42:
						Yb <= 15;
					43:
						Yb <= 15;
					44:
						Yb <= 15;
					45:
						Yb <= 15;
					46:
						Yb <= 15;
					47:
						Yb <= 15;
					48:
						Yb <= 15;
					49:
						Yb <= 15;
					50:
						Yb <= 15;
					51:
						Yb <= 15;
					52:
						Yb <= 15;
					53:
						Yb <= 15;
					54:
						Yb <= 15;
					55:
						Yb <= 16;
					56:
						Yb <= 16;
					57:
						Yb <= 16;
					58:
						Yb <= 16;
					59:
						Yb <= 16;
					60:
						Yb <= 16;
					61:
						Yb <= 16;
					62:
						Yb <= 16;
					63:
						Yb <= 16;
					64:
						Yb <= 16;
					65:
						Yb <= 16;
					66:
						Yb <= 16;
					67:
						Yb <= 16;
					68:
						Yb <= 16;
					69:
						Yb <= 16;
					70:
						Yb <= 16;
					71:
						Yb <= 16;
					72:
						Yb <= 16;
					73:
						Yb <= 16;
					74:
						Yb <= 16;
					75:
						Yb <= 16;
					76:
						Yb <= 16;
					77:
						Yb <= 16;
					78:
						Yb <= 16;
					79:
						Yb <= 16;
					80:
						Yb <= 16;
					default:
						Yb <= 0;
				endcase
				if (ACC > 80)
					Yb <= 16;
				if (ACC < -80)
					Yb <= 0;
			end
			RESULT: begin
				Y <= Yb;
				Ready <= 1'b1;
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
				ACC <= 0;
				Yb <= 0;
				Ready <= 1'b0;
			end
		endcase
	end
endmodule