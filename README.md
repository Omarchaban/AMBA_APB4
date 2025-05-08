# Overview
The AMBA APB4 Protocol project implements the Advanced Peripheral Bus (APB) protocol, part of the AMBA (Advanced Microcontroller Bus Architecture) family. This protocol is designed to offer a low-complexity, low-power interface for communication with peripherals in modern System-on-Chip (SoC) designs. It is particularly suited for connecting low-speed peripherals such as timers, UARTs, GPIOs, and configuration registers, where high performance is not required.
# Protocol Architecture
This project involves implementing the AMBA APB protocol, consisting of an APB master, an APB slave, and an external system (such as a CPU). The external system sends commands to the APB master, which then communicates these commands to the APB slave. Inside the APB slave, a cache memory is integrated to facilitate testing of write and read processes. The testbench simulates the external system, allowing for the verification of the protocol's functionality.
# Key Architectural Features
Non-Pipelined Bus Interface: Ensures straightforward communication with peripherals, minimizing complexity.
Single Clock Edge Operation: Simplifies timing and reduces power usage, critical for battery-operated devices.
Three-State Control: The protocol operates in three distinct states—IDLE, SETUP, and ACCESS—to manage data transfer efficiently.
# UVM
Different test cases are used to Verify the Functionality of the design and they are:
1-Writing to different locations then reading from them with random data
2-Writing with wait states 
3-Reading with wait states
4-Writing and reading from address Limits
5-Testing all Strobes with different data 
6-Transactions that inject error
Also some Assertions were used to test some Functionality


