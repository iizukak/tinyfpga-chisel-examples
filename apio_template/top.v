module BlinkModule( // @[:@3.2]
  input   clock, // @[:@4.4]
  output  io_led // @[:@6.4]
);
  reg [22:0] value; // @[Counter.scala 26:33:@8.4]
  reg [31:0] _RAND_0;
  reg  blink_state; // @[Blink.scala 35:28:@9.4]
  reg [31:0] _RAND_1;
  wire [23:0] _T_14; // @[Counter.scala 35:22:@11.4]
  wire  _T_17; // @[Blink.scala 38:22:@14.4]
  wire  _T_18; // @[Blink.scala 39:20:@16.6]
  assign _T_14 = value + 23'h1; // @[Counter.scala 35:22:@11.4]
  assign _T_17 = value == 23'h0; // @[Blink.scala 38:22:@14.4]
  assign _T_18 = ~ blink_state; // @[Blink.scala 39:20:@16.6]
  assign io_led = blink_state; // @[Blink.scala 41:10:@19.4]
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE
  integer initvar;
  initial begin
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      #0.002 begin end
    `endif
  `ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  value = _RAND_0[22:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  blink_state = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    value <= value + 23'h1;
    if (_T_17) begin
      blink_state <= _T_18;
    end
  end
endmodule
module top( // @[:@21.2]
  input   clock, // @[:@22.4]
  output  io_led // @[:@23.4]
);
  wire  BlinkModule_clock; // @[Blink.scala 24:30:@25.4]
  wire  BlinkModule_io_led; // @[Blink.scala 24:30:@25.4]
  BlinkModule BlinkModule ( // @[Blink.scala 24:30:@25.4]
    .clock(BlinkModule_clock),
    .io_led(BlinkModule_io_led)
  );
  assign io_led = BlinkModule_io_led; // @[Blink.scala 25:12:@28.4]
  assign BlinkModule_clock = clock; // @[:@26.4]
endmodule
