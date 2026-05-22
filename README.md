# APB Protocol Controller

## Overview
This project implements the AMBA APB (Advanced Peripheral Bus) protocol using Verilog HDL. The design includes both APB Master and APB Slave modules with complete read/write transaction support, address decoding, and control signal generation.

The APB controller is designed for low-power peripheral communication and verified using Verilog testbenches in Vivado.

---

## Features
- APB Master Design
- APB Slave Design
- Read and Write Transaction Support
- Address Decoding Logic
- APB Control Signal Generation
- Synchronous Communication
- Verilog RTL Design
- Verified using Vivado Simulation

---

## APB Signals Used

### Control Signals
- PCLK
- PRESETn
- PSEL
- PENABLE
- PWRITE

### Address & Data Signals
- PADDR
- PWDATA
- PRDATA

### Status Signals
- PREADY
- PSLVERR

---

## APB Transfer Phases

### 1. Setup Phase
- Master asserts PSEL
- Address and control signals are generated
- PENABLE remains LOW

### 2. Access Phase
- PENABLE is asserted HIGH
- Read or write transaction takes place
- Transfer completes when PREADY is HIGH

---

## Read Operation
- Master places address on PADDR
- PWRITE is set LOW
- Slave returns data through PRDATA
- Master reads data when PREADY becomes HIGH

---

## Write Operation
- Master places address on PADDR
- Write data is placed on PWDATA
- PWRITE is set HIGH
- Slave stores data after PENABLE assertion

---

## Tools Used
- Verilog HDL
- Xilinx Vivado
- Verilog Testbench

---

## Project Structure

```text
├── rtl/
│   ├── apb_master.v
│   ├── apb_slave.v
│   ├── address_decoder.v
│   ├── apb_controller_top.v
│
├── testbench/
│   └── tb_apb_top.v
│
├── simulation/
│   └── waveform.png
│
└── README.md
