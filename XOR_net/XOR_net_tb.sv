`timescale 1 ns/ 1 ns
module XOR_net_tb();
//Set time for 820 ns
// Simulation time is set to 820 ns to ensure all test inputs are applied and results can be observed
// Note: Correct output values will tend towards 0 or 16.
logic En;
logic Run;
logic [7:0] X1;
logic [7:0] X2;
logic clk;
logic rst;
// wires                                               
logic [1:0]  Ready_Bus;
logic [7:0]  Y1;

// assign statements (if any)                          
XOR_net i1 (
// port map - connection between master ports and signals/registers   
	.En(En),
	.Ready_Bus(Ready_Bus),
	.Run(Run),
	.X1(X1),
	.X2(X2),
	.Y1(Y1),
	.clk(clk),
	.rst(rst)
);
initial                                                
begin                                                  
// code that executes only once                        
// insert code here --> begin                          
En = 1;
rst = 0;
Run = 1;
X1 = 0;
X2 = 0;
#140
X1 = 0;
X2 = 16;
#140 
X1 = 16;
X2 = 16;
#140 
X1 = 16;
X2 = 0;
#140  
#140                                                      
// --> end                                             
$display("Running testbench");                       
end                                                    
always                                                 
// optional sensitivity list                           
// @(event1 or event2 or .... eventn)                  
begin                                                  
// code executes for every event on sensitivity list   
// insert code here --> begin                          
clk <= 1;
#10;
clk <= 0;
#10;                                                       
                                            
// --> end                                             
end                                                    
endmodule
