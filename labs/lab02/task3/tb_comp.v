// tb_comp2.v
`timescale 1ns/1ps

module tb_comp2;

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