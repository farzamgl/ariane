
module ariane_nonsynth_host #(
)(
    input        clk_i,
    input        ex_i,
    input [63:0] cause_i,

    input [63:0] cycle_i,
    input [63:0] instret_i
);


  localparam CAUSE_USER_ECALL       = 64'h8;
  localparam CAUSE_SUPERVISOR_ECALL = 64'h9;
  localparam CAUSE_MACHINE_ECALL    = 64'ha;

  wire is_ecall = (cause_i == CAUSE_USER_ECALL)
                  | (cause_i == CAUSE_SUPERVISOR_ECALL)
                  | (cause_i == CAUSE_MACHINE_ECALL);

  always_ff @(negedge clk_i) begin
    if(ex_i && is_ecall) begin
      $display("[CORE FSH]");
      $display("\tclk   : %d", cycle_i);
      $display("\tinstr : %d", instret_i);
      $display("\tmIPC  : %d", instret_i * 1000 / cycle_i);
      $finish();
    end
  end

endmodule
