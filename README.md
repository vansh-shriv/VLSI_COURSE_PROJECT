# High-Speed Multiplier Design in Verilog  
## Array Multiplier • Wallace Tree Multiplier • MAC (Multiply–Accumulate) Unit  
### Simulation using Icarus Verilog + GTKWave

---

## Project Overview

This project implements and compares **three multiplier architectures** in Verilog:

1. **Array Multiplier**  
2. **Wallace Tree Multiplier (Carry-Lookahead Optimized)**  
3. **MAC Unit (Multiplier + Accumulator)**

You will learn how structural differences affect **latency, area usage, and power**, and validate all designs using simulation waveforms.  
This project is suitable for **VLSI Design / Digital Design courses**.

---

## Features

- Fully synthesizable Verilog code  
- Testbenches with self-checking assertions  
- Comparative analysis table (delay, gates, switching activity)  
- Uses:
  - **Icarus Verilog** for compilation & simulation  
  - **GTKWave** for waveform visualization  
- Modular design: Each multiplier is isolated and testable

---

## Project Structure

project/
│
├── docs/
│ ├── diagrams/  
├── src/
│ ├── multiplier_array.v
│ ├── multiplier_wallace.v
│ ├── multiplier_fast.v
│ ├── csa3_16.v
│ ├── mac_unit.v
│ ├── full_adder.v
│ ├── half_adder.v
│
├── tb/
│ ├── tb_multiplier.v
│ ├── tb_multiplier_fast.v
│ ├── tb_multiplier_wallace.v
│ ├── tb_mac.v
│
├── waves/
│ ├── multiplier_array.vcd
│ ├── multiplier_wallace.vcd
│ ├── multiplier_fast.vcd
│ └── mac_unit.vcd
│
├── README.md
└── (optional) LICENSE

---

## 🛠️ Installation & Requirements

### **1. Install Icarus Verilog (Windows)**
Download from:  
https://bleyer.org/icarus/

### **2. Install GTKWave**
Download from:  
http://gtkwave.sourceforge.net/

---

## ▶️ How to Run Simulations

### **Array Multiplier**
```bash
iverilog -o array.out src/array_multiplier.v tb/tb_array.v
vvp array.out
gtkwave waves/array.vcd &

Wallace Multiplier
iverilog -o mult_wallace.out src/wallace_multiplier.v tb/tb_wallace.v
vvp wallace.out
gtkwave waves/wallace.vcd &

MAC Unit
bash
Copy code
iverilog -o mac.out src/mac_unit.v tb/tb_mac.v
vvp mac.out
gtkwave waves/mac.vcd &


Metric	Array Multiplier	Wallace Tree + CLA	MAC Unit
Gate Delay (approx.)	High (O(n))	Very Low (O(log n))	Medium–High
Area Usage	High	Medium	High
Speed	Slowest	Fastest	Fast (depends on adder)
Power (switching)	Moderate	Highest (more hardware)	Depends on accumulator width
Best Use Case	Low-power devices	High-speed DSP	FIR filters, ML accelerators

🔍 Observations
Array Multiplier
    Simple to implement
    Long critical path → slow
    Good for small bit-width (8–16 bits)

Wallace Tree + CLA
    Parallel partial product reduction
    Very high speed
    Best architecture for multipliers in CPUs/DSPs

MAC Unit
    Used in:
        FIR filters
        Neural network accelerators
        DSP convolution pipelines
    Speed dependent on adder + multiplier latency

Waveform Visualization
All output waveforms are saved inside waves/*.vcd and can be viewed using GTKWave.
Important signals include:
    a, b, acc, reset, mac_out
    Partial products (Wallace)
    Carry bits (CLA)
    Timing and latency comparison

Conclusion
This project demonstrates:

    How different multiplier architectures affect performance, area, and power
    The advantage of Wallace Tree with CLA for high-speed applications
    The real-world importance of MAC units in DSP/ML hardware

We can extend this by:

    Synthesizing in Yosys + OpenLane
    Creating GDS layout
    Adding a Booth multiplier
    Power analysis using switching activity (VCD → SAIF)