// and_gates.v
// Three AND-gate implementations instantiated by the given tb.v
// Do not modify tb.v -- this file only defines and_df, and_beh_before,
// and and_beh_intra to match tb.v's instantiations.

// ---------------------------------------------------------------------
// 1) Dataflow (continuous assignment) with delay.
//    The RHS (a & b) is evaluated immediately on any change of a or b,
//    and the output update is scheduled #5 time units later. Each new
//    edge re-triggers evaluation and reschedules using the current
//    inputs, so this tracks the correct AND function, delayed by 5.
// ---------------------------------------------------------------------
module and_df (
  input  a, b,
  output y
);
  assign #5 y = a & b;
endmodule

// ---------------------------------------------------------------------
// 2) Behavioral, BUGGY delay placement.
//    The delay (#5) comes BEFORE the assignment: the process wakes on
//    a change of a/b, waits 5 time units, and only THEN samples a & b
//    -- using whatever values a and b have at that LATER time, not the
//    values that caused the wakeup. If inputs toggle faster than the
//    delay (as in tb.v), this reads stale/incorrect data.
// ---------------------------------------------------------------------
module and_beh_before (
  input      a, b,
  output reg y
);
  always @(a or b) begin
    #5;
    y = a & b;
  end
endmodule

// ---------------------------------------------------------------------
// 3) Behavioral, CORRECT delay placement (intra-assignment delay).
//    The RHS (a & b) is evaluated IMMEDIATELY when the process wakes,
//    using the values at the time of the triggering edge. Only the
//    assignment of y is scheduled to occur #5 time units later. This
//    correctly captures the input values at the moment they changed.
// ---------------------------------------------------------------------
module and_beh_intra (
  input      a, b,

  output reg y
  
);
  always @(a or b)
    y = #5 (a & b);
endmodule