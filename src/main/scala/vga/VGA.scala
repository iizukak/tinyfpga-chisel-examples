//
// This is the VGA Moniter Controller for TinyFPGA BX
//
// Wire Connection
//
// pin24: 25Mhz clock input from Oscillator
// pin23: HSync output
// pin22: VSync output
// pin1:  RED color output
// pin2:  GREEN color output
// pin3:  BLUE color output
//

package vga
import chisel3._
import chisel3.core.withClockAndReset
import chisel3.experimental.RawModule
import chisel3.util.Counter

class VGARawModule extends RawModule {
  override def desiredName:String = "top"

  val io = IO(new Bundle {
    // for Crystal Oscillator
    val pin_24 = Input(Clock())

    // for HSync and VSync
    val pin_23 = Output(Bool())
    val pin_22 = Output(Bool())

    // for RGB
    val pin_1 = Output(Bool())
    val pin_2 = Output(Bool())
    val pin_3 = Output(Bool())
  })

  withClockAndReset(io.pin_24, false.B) {
    val vga_module = Module(new VGAModule())

    io.pin_23 := vga_module.io.hsync
    io.pin_22 := vga_module.io.vsync
    io.pin_1 := vga_module.io.red
    io.pin_2 := vga_module.io.green
    io.pin_3 := vga_module.io.blue
  }
}

class VGAModule() extends Module {
  val h_screen_size = 640
  val h_front_porch_size = 16
  val h_pulse_size = 96
  val h_back_porch_size = 48

  val v_screen_size = 480
  val v_front_porch_size = 10
  val v_pulse_size = 2
  val v_back_porch_size = 33

  val h_counter = Counter(h_screen_size + h_front_porch_size
                          + h_pulse_size + h_back_porch_size)
  val v_counter = Counter(v_screen_size + v_front_porch_size
                          + v_pulse_size + v_back_porch_size)

  val io = IO(new Bundle {
    // for HSync and VSync
    val hsync = Output(Bool())
    val vsync = Output(Bool())

    // for RGB
    val red = Output(Bool())
    val green = Output(Bool())
    val blue = Output(Bool())
  })

  val hsync_state = RegInit(true.B)
  val vsync_state = RegInit(true.B)

  val red_state = RegInit(true.B)
  val green_state = RegInit(true.B)
  val blue_state = RegInit(true.B)

  io.red := red_state
  io.green := green_state
  io.blue := blue_state

  // Horizontal Sync
  when(h_counter.value > (h_screen_size + h_front_porch_size).U &&
    h_counter.value <= (h_screen_size + h_front_porch_size + h_pulse_size).U) {
    hsync_state := false.B
  }.otherwise{
    hsync_state := true.B
  }
  io.hsync := hsync_state

  // Vertical Sync
  when(v_counter.value > (v_screen_size + v_front_porch_size).U &&
    v_counter.value <= (v_screen_size + v_front_porch_size + v_pulse_size).U) {
    vsync_state := false.B
  }.otherwise{
    vsync_state := true.B
  }
  io.vsync:= vsync_state

  h_counter.inc()
  when(h_counter.value === 0.U) {
    v_counter.inc()
  }
}

object VGA extends App {
  chisel3.Driver.execute(Array("--target-dir", "target/vga"), () => new VGARawModule)
}
