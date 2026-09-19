// tb.v
// Testbench for LUT

module tb;

  // Inputs
  reg [$clog2(4)-1:0] t_sel;

  // Output
  wire [7:0] t_dout;

  // Instantiate DUT
  lut #(
    .WIDTH(8),
    .DEPTH(4)
  ) DUT (
    .sel(t_sel),
    .dout(t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;

  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // Apply different input combinations
  initial begin
    t_sel = 0;
    #10;

    t_sel = 1;
    #10;

    t_sel = 2;
    #10;

    t_sel = 3;
    #10;

    $finish;
  end

  initial
    $monitor($time, " sel=%b | dout=%d", t_sel, t_dout);

endmodule