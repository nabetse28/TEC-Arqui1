module Hazard_Unit(
  input logic [3:0] RA1E,
  input logic [3:0] RA2E,
  input logic [3:0] WA3M,
  input logic [3:0] WA3W,
  input logic [3:0] RA1D,
  input logic [3:0] RA2D,
  input logic [3:0] WA3E,
  input logic RegWriteM,
  input logic RegWriteW,
  input logic MemtoRegE,
  output logic [1:0] ForwardAE,
  output logic [1:0] ForwardBE,
  output logic StallF,
  output logic StallD,
  output logic FlushE
);

  logic Match_12D_E, LDRstall;

  // forward memory
  assign Match_12D_E = ((RA1D == WA3E) || (RA2D == WA3E));

  assign LDRstall = Match_12D_E && MemtoRegE;

  assign StallF = LDRstall;
  assign StallD = LDRstall;
  assign FlushE = LDRstall;

  always_comb  begin
    //foward register A
    if(RA1E == WA3M && RegWriteM) begin
      ForwardAE = 2'b10 ;
    end

    else if(RA1E == WA3W && RegWriteW) begin
      ForwardAE = 2'b01;
    end

    else begin
      ForwardAE = 2'b00;
    end


    // forward register B
    if(RA2E == WA3M && RegWriteM) begin
      ForwardBE = 2'b10 ;
    end

    else if(RA2E == WA3W  && RegWriteW) begin
     ForwardBE = 2'b01;
    end

    else begin
      ForwardBE = 2'b00;
    end

  end



endmodule 