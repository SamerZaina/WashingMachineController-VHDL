---

# 🧺 Washing Machine Controller – VHDL FSM Project

## 📌 Project Overview

This project implements a **Finite State Machine (FSM) based Washing Machine Controller** using **VHDL**.

The design simulates a programmable washing machine system that controls washing, rinsing, and spinning cycles.
It is developed using **Intel Quartus Prime** and tested via simulation.

The controller interacts with:

* User program selection input
* Start / Reset signals
* Clock division module
* Seven-segment display driver

---

## 🎯 Project Objectives

* Design a **Finite State Machine (FSM)** in VHDL
* Implement modular hardware components
* Display system states on a seven-segment display
* Simulate washing machine cycle transitions
* Apply synchronous digital system design principles

---

## 🏗️ System Architecture

The project consists of multiple VHDL modules:

### 1️⃣ `WashingMachineController.vhd`

Main FSM controller:

* Controls washing cycle states
* Handles user program selection
* Manages state transitions

---

### 2️⃣ `Clk_Divider.vhd`

Clock divider module:

* Reduces system clock frequency
* Generates slower clock for timing control

---

### 3️⃣ `seven_seg_decoder.vhd`

Seven-segment decoder:

* Converts binary input into segment signals
* Displays numbers and characters

---

### 4️⃣ `seven_seg_decoder_tb.vhd`

Testbench for decoder:

* Verifies correct segment outputs
* Used for simulation validation

---

### 5️⃣ `showword.vhd`

Display control module:

* Drives seven-segment display output
* Manages displayed words based on state

---

## ⚙️ Inputs & Outputs

### Inputs:

* `clk` – System clock
* `reset` – System reset
* `start` – Start washing cycle
* `userProg` – 5-bit program selector

### Outputs:

* `sevseg_data` – 7-segment display segments
* `sevseg_driver` – Display enable lines
* `state` – Current FSM state

---

## 🔄 FSM Operation

The controller transitions between states such as:

1. Idle
2. Washing
3. Rinsing
4. Spinning

State transitions depend on:

* Start signal
* Reset signal
* Program selection
* Cycle completion timing

---

## 🛠️ Tools Used

* VHDL
* Intel Quartus Prime
* ModelSim / NativeLink Simulation
* FPGA Digital Design Principles

---

## 📂 Project Structure

```
FinalProject/
│
├── Clk_Divider.vhd
├── seven_seg_decoder.vhd
├── seven_seg_decoder_tb.vhd
├── showword.vhd
├── WashingMachineController.vhd
├── VHDL_FINALPROJECT.qpf
├── VHDL_FINALPROJECT.qsf
├── simulation/
└── README.md
```

---

## ▶️ How to Run

1. Open **Quartus Prime**
2. Open `VHDL_FINALPROJECT.qpf`
3. Compile the project
4. Run simulation using ModelSim / NativeLink
5. Observe FSM state transitions and display outputs

---

## 📚 Academic Context

This project was developed as part of a **Digital Systems / VHDL Design course**.

It demonstrates:

* FSM modeling
* Modular VHDL design
* Hardware abstraction
* Synchronous digital design

---

## 👨‍💻 Author

**Eng. Samer Alaa Abu Zaina**
Embedded Systems & Digital Design

---
