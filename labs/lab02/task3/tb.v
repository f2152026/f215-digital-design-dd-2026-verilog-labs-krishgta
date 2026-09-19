// tb.v
`timescale 1ns/1ps

module tb;


  reg  [1:0] A, B;
  wire       GT, LT, EQ;
  integer    i, j;
  integer    errors = 0;

  comp2 dut (
    .A  (A),
    .B  (B),
    .GT (GT),
    .LT (LT),
    .EQ (EQ)
  );

  task check;
    reg exp_gt, exp_lt, exp_eq;
    integer onehot_count;
    begin
      exp_gt = (A > B);
      exp_lt = (A < B);
      exp_eq = (A == B);

      onehot_count = GT + LT + EQ;

      if (onehot_count !== 1) begin
        $display("ERROR: A=%0d B=%0d -> GT=%b LT=%b EQ=%b (not one-hot, count=%0d)",
                  A, B, GT, LT, EQ, onehot_count);
        errors = errors + 1;
      end
      else if ({GT,LT,EQ} !== {exp_gt,exp_lt,exp_eq}) begin
        $display("ERROR: A=%0d B=%0d -> got GT=%b LT=%b EQ=%b, expected GT=%b LT=%b EQ=%b",
                  A, B, GT, LT, EQ, exp_gt, exp_lt, exp_eq);
        errors = errors + 1;
      end
    end
  endtask

  initial begin
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        A = i[1:0];
        B = j[1:0];
        #1;
        check;
      end
    end

    if (errors == 0)
      $display("ALL TESTS PASSED");
    else
      $display("%0d TEST(S) FAILED", errors);

    $finish;
  end

endmodule

And the fixed comp2.v (same as before, in case you still need it):

verilog
// comp2.v
// 2-bit unsigned magnitude comparator.
// Given two 2-bit values A and B, exactly one of GT, LT, EQ should be 1
// for any input combination.

module comp2 (
  input  [1:0] A,
  input  [1:0] B,
  output       GT,
  output       LT,
  output       EQ
);

  assign EQ = (A == B);
  assign GT = (A >  B);   // fixed: was A >= B, which overlapped with EQ
  assign LT = (A <  B);

endmodule