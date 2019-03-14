// See README.md for license details.
//
// This file is based on under the repository
// https://github.com/indyscala/chisel3
//

package blink

import chisel3._
import chisel3.core.withClockAndReset
import chisel3.experimental.RawModule
import chisel3.util.Counter

/**
  * Blink built-in LED.
  */
class BlinkRawModule extends RawModule {
  val clock = IO(Input(Clock()))
  override def desiredName:String = "top"

  val io = IO(new Bundle {
    val led = Output(Bool())
  })

  withClockAndReset(clock, false.B) {
    val blink_freq = 8388608
    val blink_module = Module(new BlinkModule(blink_freq))
    io.led := blink_module.io.led
  }
}

class BlinkModule(clocksBetweenToggle: Int) extends Module {
  val io = IO(new Bundle {
    val led = Output(Bool())
  })

  val counter = Counter(clocksBetweenToggle)
  val blink_state = RegInit(0.U(1.W))

  counter.inc()
  when(counter.value === 0.U) {
    blink_state := ~blink_state
  }
  io.led := blink_state
}

object Blink extends App {
  chisel3.Driver.execute(Array("--target-dir", "target/led"), () => new BlinkRawModule)
}
