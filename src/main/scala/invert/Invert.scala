// See README.md for license details.
//
// This file is based on under the repository
// https://github.com/indyscala/chisel3
//
package invert
import chisel3._
import chisel3.experimental.RawModule

class InvertRawModule extends RawModule {
  override def desiredName:String = "top"

  val io = IO(new Bundle {
    val pin_1 = Input(Bool())
    val led = Output(Bool())
  })

  io.led := ~io.pin_1
}

object Invert extends App {
  chisel3.Driver.execute(Array("--target-dir", "target/invert"), () => new InvertRawModule)
}
