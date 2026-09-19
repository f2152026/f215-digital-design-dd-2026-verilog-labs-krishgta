// tb.v
// Starter testbench template

module tb;



  // Declare DUT inputs as reg
  reg t_i0, t_i1, t_s;
  
  // Declare DUT output as wire
  wire t_y;

  // Instantiate DUT
  DUT uut (
    .I0 (t_i0),
    .I1 (t_i1),
    .S  (t_s),
    .Y  (t_y)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // Test stimulus: Iterate through all 8 input combinations 5 time units apart
  integer i;
  initial begin
    for (i = 0; i < 8; i = i + 1) begin
      {t_i0, t_i1, t_s} = i[2:0];
      #5;
    end
    $finish;
  end

  initial
    $monitor($time, " I0=%b I1=%b S=%b | Y=%b", t_i0, t_i1, t_s, t_y);

endmodule