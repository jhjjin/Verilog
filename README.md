# Verilog Labs — Nexys A7
```
A collection of small Verilog modules and testbenches. Most designs target the Digilent Nexys A7-100T (Artix-7) in Vivado; some are simulation-only examples.
```

--- 
## Project layout
```
verilog/
├─ 4_to_16_Decoder.v         # 4→16 decoder + 7-seg controller (Top: connect)
├─ BCD_Counter.v             # 4-bit BCD counter chain (example top: topCounter)
├─ Blocking.v                # Blocking assignment demo 
├─ D_Latch.v                 # D latch 
├─ Moore_Mealy.v             # Edge detectors (Moore/Mealy) 
├─ Mux_8_1.v                 # 8:1 mux 
├─ Overflow.v                # n-bit add, carry, overflow 
├─ Parallel.v                # 4-bit parallel load / shift (muxed DFF)
├─ Reduction.v               # Reduction XOR/XNOR 
├─ Shift.v                   # 4-bit shift register 
├─ SongPlayer_NexysA7.v      # PWM audio: “Row Row Your Boat”
├─ SongPlayer_NexysA7.xdc    # XDC for SongPlayer
├─ Synchronous_Counter.v     # 3-bit synchronous counter (example top: topCounter)
├─ T_flip_flop.v             # 3-bit T “counter-like” register 
├─ VGA_Test_NexysA7.v        # Simple VGA color buffer (needs vga_sync)
└─ VGA_Test_NexysA7.xdc      # XDC for VGA test
```

---
## Common fixes / lint tips
```
- Top name clash: rename one of the topCounter modules (e.g., topCounter_bcd, topCounter_sync).
- Blocking vs non-blocking: use <= for sequential logic (always @posedge).
  Example: in Parallel.v → muxdff uses Q = D; → change to Q <= D;.
- Integer literals: write with width/base in TBs, e.g., A = 8'b01001000; (not A=01001000; which is decimal).
- D latch ports: prefer output reg Q; single declaration (instead of separate output Q; reg Q;).
- Mux default: add default: f = 1'bx; in mux8to1 for safety.
- SongPlayer note periods: constants like C4=95556.62 will be truncated to integers; verify exact integer periods for 100 MHz. 
```
---
## Simulation tops
```
- Set these testbench modules as the simulation top in Vivado:
  Blocking.v → sim_blockingExp3
  D_Latch.v → sim_dlatch
  Moore_Mealy.v → sim_topModule
  Mux_8_1.v → Sim_8To1Mux
  Overflow.v → sim_overflow
  Reduction.v → sim_Reduction
  Shift.v → sim_shift
  T_flip_flop.v → sim_tff
  Run Flow → Run Behavioral Simulation and inspect waveforms.
```

--- 
## Module notes
```
- 7-segment display (4_to_16_Decoder.v)
  connect (top): 4-bit data → 1-hot decode → drives C (segments) and AN (anodes).
  decoder: 4→16 one-hot (y[data] = 1’b1;).
  controller: maps one-hot to 7-segment glyphs 0–F; defaults all segments/anodes off.
- Counters
  BCD_Counter.v: chained BCD counters (demo). Shares topCounter name—rename if needed.
  Synchronous_Counter.v: 3-bit synchronous counter (demo). Shares topCounter name—rename if needed.
  T_flip_flop.v: 3-bit register updated by T;
- Seq/comb basics
  D_Latch.v: level-sensitive D latch with En; 
  Parallel.v: muxed-DFF 4-stage shift with parallel load.
  Shift.v: 4-bit shift register using non-blocking (<=);
  Blocking.v: blocking assignment order demo;
  Reduction.v: ^A/~^A reduction ops;
  Mux_8_1.v: 8:1 mux; 
- Arithmetic/flags
  Overflow.v: parameterized n-bit add with carryout and signed overflow; 
- Peripherals
  SongPlayer_NexysA7.v: PWM audio on audioOut, amp enable on aud_sd=1.
  Clock assumed 100 MHz (clockFrequency = 100_000_000). Use SongPlayer_NexysA7.xdc.
  VGA_Test_NexysA7.v: routes switches to RGB.
  Requires external vga_sync module (not included here). Use VGA_Test_NexysA7.xdc.
  Typical pixel clock ~25 MHz; generate via MMCM/PLL if needed.
```
## XDC highlights
```
- SongPlayer_NexysA7.xdc
  Clock: port clock at 100 MHz (create_clock provided).
  Switches: reset, playSound.
  Audio pins: audioOut (PWM), aud_sd (amp enable).
- VGA_Test_NexysA7.xdc
  VGA: VGA_R[3:0], VGA_G[3:0], VGA_B[3:0], VGA_HS, VGA_VS.
  The default CLK100MHZ lines are commented; align the clock port name with your top (vga_sync expects a specific clock).
  Reminder: XDC get_ports { ... } names must exactly match the top-level port names.
```
---
## Common fixes 
```
- Top name clash: rename one of the topCounter modules (e.g., topCounter_bcd, topCounter_sync).
- Blocking vs non-blocking: use <= for sequential logic (always @posedge).
  Example: in Parallel.v → muxdff uses Q = D; → change to Q <= D;.
- Integer literals: write with width/base in TBs, e.g., A = 8'b01001000; (not A=01001000; which is decimal).
- D latch ports: prefer output reg Q; single declaration (instead of separate output Q; reg Q;).
- Mux default: add default: f = 1'bx; in mux8to1 for safety.
- SongPlayer note periods: constants like C4=95556.62 will be truncated to integers; verify exact integer periods for 100 MHz.
```
