// comp2.v
// 2-bit unsigned magnitude comparator

module comp2 (
  input  wire [1:0] A,
  input  wire [1:0] B,
  output wire GT,
  output wire LT,
  output wire EQ
);

  assign GT = (A > B);
  assign LT = (A < B);
  assign EQ = (A == B);

endmodule