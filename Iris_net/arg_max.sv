module arg_max #(parameter DATA_WIDTH = 8)(
	input logic clk,
	input logic En,
	input logic rst,
	input logic Run,
	input logic signed [DATA_WIDTH+5:0] XS1,
	input logic signed [DATA_WIDTH+5:0] XS2,
	input logic signed [DATA_WIDTH+5:0] XS3,
	output logic [2:0] Yc,
	output logic Ready_arg
	);

	logic signed[DATA_WIDTH+5:0] array[3];
	logic is_max[3];

	parameter FLUSH_PIPELINE = 4'b0111;
	parameter BYPASS_INPUTS = 4'b1000;
	parameter IDLE = 4'b0000;
	parameter LOAD_INPUTS = 4'b0001;
	parameter COMPARE = 4'b0010;
	parameter WAIT_1 = 4'b0011;
	parameter WAIT_2 = 4'b0100;
	parameter WAIT_3 = 4'b0101;
	parameter RESULT = 4'b0110;

	reg [3:0] Current_State = FLUSH_PIPELINE;

	integer i;

	always@(posedge clk or posedge rst) begin
		if (rst) begin
			Current_State <= FLUSH_PIPELINE;
		end else if (En) begin
			case(Current_State)
				FLUSH_PIPELINE: begin
					if (Run)
						Current_State <= BYPASS_INPUTS;
					else
						Current_State <= FLUSH_PIPELINE;
				end
				IDLE: begin
					if (Run)
						Current_State <= LOAD_INPUTS;
					else
						Current_State <= FLUSH_PIPELINE;
				end
				LOAD_INPUTS: begin
					Current_State <= COMPARE;
				end
				BYPASS_INPUTS: begin
					Current_State <= COMPARE;
				end
				COMPARE: begin
					Current_State <= WAIT_1;
				end
				WAIT_1: begin
					Current_State <= WAIT_2;
				end
				WAIT_2: begin
					Current_State <= WAIT_3;
				end
				WAIT_3: begin
					Current_State <= RESULT;
				end
				RESULT: begin
					Current_State <= IDLE;
				end
				default: begin
					Current_State <= FLUSH_PIPELINE;
				end
			endcase
		end
	end
	always@(posedge clk) begin
		case(Current_State)
			FLUSH_PIPELINE: begin
				Ready_arg <= 1'b0;
				for (i = 0; i < 3; i = i + 1) begin
					array[i] <= 0;
					is_max[i] <= 1'b0;
				end
			end
			IDLE: begin
				Ready_arg <= 1'b0;
				for (i = 0; i < 3; i = i + 1) begin
					array[i] <= 0;
					is_max[i] <= 1'b0;
				end
			end
			LOAD_INPUTS: begin
				array[0] <= XS1;
				array[1] <= XS2;
				array[2] <= XS3;
			end
			BYPASS_INPUTS: begin
				array[0] <= array[0];
				array[1] <= array[1];
				array[2] <= array[2];
			end
			COMPARE: begin
				is_max[0] <= (array[0] >= array[1]) && (array[0] >= array[2]);
				is_max[1] <= (array[1] >= array[0]) && (array[1] >= array[2]);
				is_max[2] <= (array[2] >= array[0]) && (array[2] >= array[1]);
			end
			WAIT_1: begin
				is_max[0] <= is_max[0];
				is_max[1] <= is_max[1];
				is_max[2] <= is_max[2];
			end
			WAIT_2: begin
				is_max[0] <= is_max[0];
				is_max[1] <= is_max[1];
				is_max[2] <= is_max[2];
			end
			WAIT_3: begin
				is_max[0] <= is_max[0];
				is_max[1] <= is_max[1];
				is_max[2] <= is_max[2];
			end
			RESULT: begin
				case(1'b1)
					is_max[0]: Yc <= 0;
					is_max[1]: Yc <= 1;
					is_max[2]: Yc <= 2;
					default: Yc <= 0;
				endcase
				Ready_arg <= 1'b1;
			end
			default: begin
				for (i = 0; i < 3; i = i + 1) begin
					array[i] <= array[i];
					is_max[i] <= 1'b0;
				end
				Ready_arg <= 1'b0;
			end
		endcase
	end
endmodule