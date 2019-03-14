// See README.md for license details.
//
package iotest
import chisel3._
import chisel3.experimental.RawModule

class IOTestRawModule extends RawModule {
  override def desiredName:String = "top"

  val io = IO(new Bundle {
    val pin_2 = Output(Bool())
  })

  io.pin_2 := true.B
}

object IOTest extends App {
  chisel3.Driver.execute(Array("--target-dir", "target/iotest"), () => new IOTestRawModule)
}
