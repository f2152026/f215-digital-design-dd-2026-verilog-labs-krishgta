// dut.v
// Top-level wrapper for the 2-to-1 multiplexer

module DUT (
  input  I0,
  input  I1,
  input  S,
  output Y
);

  // Option 1: dataflow version
  mux_df U1 (
    .I0(I0),
    .I1(I1),
    .S(S),
    .Y(Y)
  );

  // Option 2: behavioral version
  // Uncomment this and comment Option 1 to test mux_beh.
  // mux_beh U1 (
  //   .I0(I0),
  //   .I1(I1),
  //   .S(S),
  //   .Y(Y)
  // );

endmodule