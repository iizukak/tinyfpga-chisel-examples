module Blinker( // @[:@3.2]
  input   clock, // @[:@4.4]
  output  io_led // @[:@6.4]
);
  reg [23:0] value; // @[Counter.scala 26:33:@8.4]
  reg [31:0] _RAND_0;
  reg  blink_state; // @[Blink.scala 33:28:@9.4]
  reg [31:0] _RAND_1;
  wire  _T_12; // @[Counter.scala 34:24:@10.4]
  wire [24:0] _T_14; // @[Counter.scala 35:22:@11.4]
  wire [23:0] _T_15; // @[Counter.scala 35:22:@12.4]
  wire  _T_18; // @[Blink.scala 36:22:@17.4]
  wire  _T_19; // @[Blink.scala 37:20:@19.6]
  assign _T_12 = value == 24'hf423ff; // @[Counter.scala 34:24:@10.4]
  assign _T_14 = value + 24'h1; // @[Counter.scala 35:22:@11.4]
  assign _T_15 = value + 24'h1; // @[Counter.scala 35:22:@12.4]
  assign _T_18 = value == 24'h0; // @[Blink.scala 36:22:@17.4]
  assign _T_19 = ~ blink_state; // @[Blink.scala 37:20:@19.6]
  assign io_led = blink_state; // @[Blink.scala 39:10:@22.4]
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
  value = _RAND_0[23:0];
  `endif // RANDOMIZE_REG_INIT
  `ifdef RANDOMIZE_REG_INIT
  _RAND_1 = {1{`RANDOM}};
  blink_state = _RAND_1[0:0];
  `endif // RANDOMIZE_REG_INIT
  end
`endif // RANDOMIZE
  always @(posedge clock) begin
    if (_T_12) begin
      value <= 24'h0;
    end else begin
      value <= _T_15;
    end
    if (_T_18) begin
      blink_state <= _T_19;
    end
  end
endmodule
module top( // @[:@24.2]
  input   clock, // @[:@25.4]
  output  io_led // @[:@26.4]
);
  wire  Blinker_clock; // @[Blink.scala 22:25:@28.4]
  wire  Blinker_io_led; // @[Blink.scala 22:25:@28.4]
  Blinker Blinker ( // @[Blink.scala 22:25:@28.4]
    .clock(Blinker_clock),
    .io_led(Blinker_io_led)
  );
  assign io_led = Blinker_io_led; // @[Blink.scala 23:12:@31.4]
  assign Blinker_clock = clock; // @[:@29.4]
endmodule
