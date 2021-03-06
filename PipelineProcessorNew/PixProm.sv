module PixProm (	input logic [7:0] red, green, blue,
						output logic [31:0] Pixout);
												

logic [7:0] promedio;
assign promedio = (red+green+blue)/3;

assign Pixout = {24'b0, promedio};

endmodule
