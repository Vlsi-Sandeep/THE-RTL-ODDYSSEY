# RTL Odyssey: 30 Days, 30 Verilog Projects

> From a combinational ALU to a RISC-V SoC running on a real FPGA, one project per day, every one self-checked.

![Language](https://img.shields.io/badge/HDL-Verilog-blue)
![Sim](https://img.shields.io/badge/Simulator-Questa-orange)
![Synth](https://img.shields.io/badge/Synthesis-Vivado%20%7C%20Gowin-green)
![Board](https://img.shields.io/badge/FPGA-Tang%20Nano%204K-red)
![Progress](https://img.shields.io/badge/Progress-1%2F30-yellow)

---

## What I Learned in These 30 Projects

By the end of this challenge, I will have hands-on experience in every area below. This section is updated as each day is completed.

**RTL design fundamentals**
- Writing clean, synthesizable, parameterized Verilog (`parameter`, `localparam`, `generate`, `$clog2`)
- Combinational vs sequential coding, blocking vs non-blocking assignments, and how to avoid unintended latches
- Finite state machines in three coding styles (binary, one-hot, 3-process) and when to use each
- Signed arithmetic, two's complement, carry/overflow flags, and fixed-point (Q-format) math

**Digital building blocks**
- Shift registers, counters, LFSRs, CRC generators
- Register files, RAMs (BRAM inference), synchronous and asynchronous FIFOs
- Pipelining, valid/ready handshakes, skid buffers and back-pressure

**Clock domains and timing**
- Metastability and synchronizer design (2-FF, pulse, handshake)
- Gray-code pointers and asynchronous FIFO design
- Reading timing and utilization reports (LUTs, Fmax) after synthesis

**Communication and bus protocols**
- UART, SPI (all 4 modes), I2C
- APB, AXI4-Lite, AXI-Stream
- Memory-mapped register banks and a mini DMA engine

**Compute and DSP architectures**
- CORDIC, FIR filters, FFT butterflies
- SHA-256 hardware core
- Systolic-array matrix multiplier and a tiny neural-network inference engine (AI accelerator basics)

**Processor and SoC design**
- RV32I single-cycle core, then a 5-stage pipeline with hazard handling and forwarding
- Memory-mapped peripherals and address decoding
- A complete mini SoC running an assembled program on a Tang Nano 4K

**Verification skills (pure Verilog)**
- Self-checking testbenches with an independent reference model
- Directed corner-case tests plus constrained-random stimulus (`$random`)
- Scoreboards, bus-functional models (BFMs) written as tasks, randomized stalls
- File-driven test vectors (`$readmemh`, `$fopen`), golden-model comparison
- Regression scripts, pass/fail counters, and `.do` scripts for Questa

**Engineering practice**
- One folder per project: RTL, testbench, README, waveform
- Git workflow, documentation, and reproducible simulation flow

---

## Rules of the Challenge

1. **Pure Verilog only.** No SystemVerilog, so the fundamentals are solid before moving to UVM.
2. **Every day ships three things:** synthesizable RTL, a self-checking testbench that prints PASS/FAIL, and a README with a waveform screenshot.
3. **Every project builds on the previous one.** For example, the FIFO from Day 8 is reused in Day 17, the UART from Day 5 is reused in Day 28, and the ALU from Day 1 becomes part of the RISC-V core.
4. **Modern practice, not textbook-only.** Parameterized designs, protocol-compliant interfaces, and real tool flows.
5. **Understand before moving on.** If I can't explain every line, the day isn't done.

---

## Tools

| Purpose | Tool |
|---|---|
| Editor | VS Code |
| Simulation and waveforms | Questa (Windows) |
| Synthesis, elaborated schematic, utilization | Vivado (Ubuntu) |
| FPGA toolchain for the board | Gowin EDA |
| Hardware | Tang Nano 4K |
| Version control | Git and GitHub |

---

## Project Index

Status: ✅ done | 🚧 in progress | ⬜ planned

### Phase 1: Foundations in modern style

| Day | Project | Key concepts | Status |
|---|---|---|---|
| 01 | [Parameterized ALU](./day01_alu) | parameters, signed math, flags, self-checking TB | ✅ |
| 02 | Input conditioner (synchronizer, debouncer, edge detector) | flip-flops, metastability basics, counters | ⬜ |
| 03 | LFSR/PRBS generator and parameterized CRC | shift registers, polynomials | ⬜ |
| 04 | FSM sequence detector (binary, one-hot, 3-process) | FSM coding styles, Moore vs Mealy | ⬜ |
| 05 | UART TX and RX | baud generator, oversampling, framing | ⬜ |
| 06 | UART loopback on FPGA | constraints, clock/reset handling, board demo | ⬜ |

### Phase 2: Memory, datapaths, handshakes

| Day | Project | Key concepts | Status |
|---|---|---|---|
| 07 | Register file and dual-port RAM | BRAM inference, `$readmemh` | ⬜ |
| 08 | Synchronous FIFO | pointers, full/empty/almost flags | ⬜ |
| 09 | Valid/ready pipeline and skid buffer | handshake, back-pressure | ⬜ |
| 10 | Pipelined multiplier and fixed-point MAC | pipelining, Q-format | ⬜ |
| 11 | SPI master and slave | CPOL/CPHA modes, shift engines | ⬜ |
| 12 | I2C master | open-drain, start/stop, ACK | ⬜ |

### Phase 3: Clock domains and bus protocols

| Day | Project | Key concepts | Status |
|---|---|---|---|
| 13 | CDC toolkit | 2-FF, pulse and handshake synchronizers | ⬜ |
| 14 | Asynchronous FIFO | Gray code, pointer synchronization | ⬜ |
| 15 | APB slave and register bank | CSR fields (RO, RW, W1C), bus tasks | ⬜ |
| 16 | AXI4-Lite slave (GPIO and timer) | 5 channels, independent handshakes | ⬜ |
| 17 | AXI-Stream width converter and FIFO | `tlast`, packing/unpacking | ⬜ |
| 18 | Mini DMA engine | FSM plus bus master | ⬜ |

### Phase 4: Compute and DSP

| Day | Project | Key concepts | Status |
|---|---|---|---|
| 19 | CORDIC (sin/cos) | iterative shift-add | ⬜ |
| 20 | FIR filter | transposed form, DSP mapping | ⬜ |
| 21 | SHA-256 core | round logic, big datapaths | ⬜ |
| 22 | 8-point FFT | butterflies, twiddle factors | ⬜ |
| 23 | 4x4 systolic matrix multiplier | AI-accelerator architecture | ⬜ |
| 24 | Tiny neural-network inference engine | quantized MAC array, ReLU | ⬜ |

### Phase 5: Processor and SoC

| Day | Project | Key concepts | Status |
|---|---|---|---|
| 25 | RV32I building blocks | decoder, immediates, regfile | ⬜ |
| 26 | Single-cycle RV32I core | datapath and control | ⬜ |
| 27 | 5-stage pipelined RV32I | hazards, forwarding, flushes | ⬜ |
| 28 | Memory-mapped peripherals | address decode, interconnect | ⬜ |
| 29 | Verification day | regression, random instruction tests | ⬜ |
| 30 | Capstone: mini SoC on Tang Nano 4K | integration, timing, demo | ⬜ |

---

## How My Verification Skills Grow

| Days | Technique |
|---|---|
| 1-6 | Directed and self-checking testbenches, reference models |
| 7-12 | Scoreboards, memory models, random stalls |
| 13-18 | Multi-clock testing, bus-functional-model tasks |
| 19-24 | File-driven vectors, golden-model comparison, error tolerance |
| 25-30 | Processor-level checking, random programs, regression flow |

---

## Repository Structure

```
rtl-odyssey/
 ├── README.md              <- this file
 ├── day01_alu/
 │    ├── rtl/alu.v
 │    ├── tb/tb_alu.v
 │    ├── wave.png
 │    └── README.md
 ├── day02_input_conditioner/
 ├── ...
 └── day30_mini_soc/
```

Each day's folder follows the same layout, so any project can be run the same way.

---

## How to Run Any Project (Questa)

```
cd dayXX_name
vlib work
vlog rtl/*.v tb/*.v
vsim -voptargs=+acc work.tb_<name>
add wave -r /tb_<name>/*
run -all
```

Batch mode (no GUI):

```
vsim -c -voptargs=+acc work.tb_<name> -do "run -all; quit"
```

A passing run ends with `RESULT: ALL TESTS PASSED`.

---

## Progress Log

### Day 01: Parameterized ALU ✅
- 11 operations (ADD, SUB, AND, OR, XOR, NOT, SLL, SRL, SRA, SLT, SLTU) matching the RISC-V integer set, so it can be reused in the CPU later
- Flags: zero, negative, carry, overflow
- Width set by a single parameter (tested at 4, 8 and 16 bits)
- Self-checking testbench: exhaustive corner cases across all opcodes plus 2000 random tests against an independent integer-math reference model
- Result: 0 failures
- Learned: why `reg` doesn't always mean a flip-flop, how default assignments prevent latches, signed vs unsigned behaviour, and why testbenches use `!==` instead of `!=`

*(Entries for Days 2-30 will be added as I go.)*

---

## Why This Project

I started this challenge as a beginner who knew combinational logic and basic sequential circuits. The goal is to reach the point where the fundamentals are at my fingertips and I can design, verify and demonstrate real hardware, from a single ALU to a working RISC-V SoC on an FPGA.

My focus areas are **RTL design (50%)**, **FPGA implementation (30%)** and **design verification (20%)**.

---

## Connect

Follow along as the challenge progresses.

- GitHub: `<your-username>`
- LinkedIn: `<your-link>`

If you spot a bug or have a suggestion, feel free to open an issue.
