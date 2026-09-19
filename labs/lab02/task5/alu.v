// alu.v
// 1-bit-opcode ALU: op=0 -> add, op=1 -> sub. 4-bit operands.
// Subtraction is implemented the way real hardware does it: negate b (one's
// complement, then +1 for two's complement) and add.

module alu (
  input      [3:0] a,
  input      [3:0] b,
  input             op,      // 0 = add, 1 = sub
  output reg [3:0] result
);

  reg [3:0] b_inv;
  reg [3:0] b_twos;

  always @(*) begin              // fixed: sensitivity list now includes op
    case (op)
      1'b0: begin
        result = a + b;          // add
      end
      1'b1: begin
        b_inv  = ~b;             // fixed: blocking assignment
        b_twos = b_inv + 1;      // now sees the fresh b_inv
        result = a + b_twos;     // now sees the fresh b_twos
      end
    endcase

  end
  

endmodule