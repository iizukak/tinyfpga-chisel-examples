// See README.md for license details.

package blink

import chisel3._
import chisel3.core.withClockAndReset
import chisel3.util.Counter

/**
  * Blink built-in LED.
  */

class Blink extends Module {
  val io = IO(new Bundle {
    val led = Output(Bool())
  })
  var CNT_MAX = 8388608

  val counter = Counter(CNT_MAX)
  val blink_state = RegInit(0.U(1.W))

  withClockAndReset(clock, false.B) {
    counter.inc()
    when(counter.value === 0.U) {
      blink_state := ~blink_state
    }
    io.led := blink_state
  }
}

object Blink extends App {
  chisel3.Driver.execute(Array("--target-dir", "target/led"), () => new Blink)
}
