module Pipeline_ARM (input logic CLK_50, reset,
							output logic [31:0] ALUResult, TestInst, TestInstD);




logic [1:0] RegSrcD, ImmSrcD;
logic RegWriteW, MemtoRegW,PCSrcW,ALUSrcE, MemWriteM;
logic MemtoRegE,RegWriteM,BranchTakenE;
logic [1:0] ALUControlE;

PasoControl pasocontrol(CLK_50,FlushE,reset,
								Opcode,
								Rd, CondD,
								Funct,
								AluFlags,
								RegSrcD, ImmSrcD,
								RegWriteW, MemtoRegW,PCSrcW,ALUSrcE, MemWriteM,
								MemtoRegE,RegWriteM,BranchTakenE,
								ALUControlE);


//logic [3:0] AluFlags;
//logic [1:0] Opcode;
//logic [3:0] Rd, CondD;
logic [3:0] RA1E, RA2E, ra1d, ra2d;
//logic [5:0] Funct;
logic [3:0] WA3W, WA3E, WA3M;


PasoDatos pasodatos(.clk(CLK_50), .reset(reset),
							.PCSrcW(PCSrcW), .BranchTakenE(BranchTakenE), .StallF(StallF), .StallD(StallD), .FlushD(reset),
							.RegSrcD(RegSrcD), .ImmSrcD(ImmSrcD),
							.RegWriteW(RegWriteW),
							.FlushE(FlushE), .ALUSrcE(ALUSrcE),
							.ForwardAE(ForwardAE), .ForwardBE(ForwardBE), .AluControlE(ALUControlE),
							.MemWriteM(MemWriteM), .MemtoRegW(MemtoRegW),
							.AluFlags(AluFlags),
							.Opcode(Opcode),
							.Rd(Rd), .CondD(CondD), .RA1E(RA1E), .RA2E(RA2E), .ra1d(ra1d), .ra2d(ra2d),
							.Funct(Funct),
							.WA3W(WA3W), .WA3E(WA3E), .WA3M(WA3M),
							.ALUResult(ALUResult));

logic [1:0] ForwardAE;
logic [1:0] ForwardBE;
logic StallF,StallD,FlushE;

Hazard_Unit hazard_unit(.RA1E(RA1E),
								.RA2E(RA2E),
								.WA3M(WA3M),
								.WA3W(WA3W),
								.RA1D(ra1d),
								.RA2D(ra2d),
								.WA3E(WA3E),
								.RegWriteM(RegWriteM),
								.RegWriteW(RegWriteW),
								.MemtoRegE(MemtoRegE),
								.ForwardAE(ForwardAE),
								.ForwardBE(ForwardBE),
								.StallF(StallF), .StallD(StallD), .FlushE(FlushE));

PasoDatos pasodatos(CLK_50, reset,
							PCSrcW, BranchTakenE, StallF, StallD, FlushD,
							RegSrcD, ImmSrcD,
							RegWriteW,
							FlushE, ALUSrcE,
							ForwardAE, ForwardBE, ALUControlE,
							MemWriteM, MemtoRegW,
							AluFlags,
							Opcode,
							Rd, CondD, RA1E, RA2E, ra1d, ra2d,
							Funct,
							WA3W, WA3E, WA3M,
							ALUResult, TestInst, TestInstD);

//logic [1:0] ForwardAE;
//logic [1:0] ForwardBE;
//logic StallF,StallD,FlushE;

Hazard_Unit hazard_unit(RA1E,
								RA2E,
								WA3M,
								WA3W,
								ra1d,
								ra2d,
								WA3E,
								RegWriteM,
								RegWriteW,
								MemtoRegE,
								ForwardAE,
								ForwardBE,
								StallF, StallD,FlushE);

								
								
endmodule