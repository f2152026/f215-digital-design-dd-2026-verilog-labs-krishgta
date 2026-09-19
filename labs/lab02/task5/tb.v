// tb.v
// Self-checking testbench for alu.v
`timescale 1ns/1ps

module tb;

  reg  [3:0] a, b;
  reg        op;
  wire [3:0] result;
  integer    i, j, k;
  integer    errors = 0;
  reg  [3:0] expected;
  

  alu dut (
    .a      (a),
    .b      (b),
    .op     (op),
    .result (result)
  );

  task check;
    begin
      expected = op ? (a - b) : (a + b);
      #1; // let combinational logic settle
      if (result !== expected) begin
        $display("ERROR: a=%0d b=%0d op=%b -> got result=%0d, expected=%0d",
                  a, b, op, result, expected);
        errors = errors + 1;
      end
    end
  endtask

  initial begin
    // Exhaustive test: all a, b, op combinations
    for (i = 0; i < 16; i = i + 1) begin
      for (j = 0; j < 16; j = j + 1) begin
        for (k = 0; k < 2; k = k + 1) begin
          a  = i[3:0];
          b  = j[3:0];
          op = k[0];
          #1;
          check;
        end
      end
    end

    // Extra: specifically test op toggling with a/b held constant,
    // to catch a sensitivity-list bug
    a = 4'd5; b = 4'd3;
    op = 0; #1; check;
    op = 1; #1; check;   // if op alone doesn't retrigger, this will fail
    op = 0; #1; check;

    if (errors == 0)
      $display("ALL TESTS PASSED");
    else
      $display("%0d TEST(S) FAILED", errors);

    $finish;
  end

endmodule