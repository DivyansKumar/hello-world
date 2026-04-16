# AArch64 Architectural Study: Native macOS System Interfacing

A low-level exploration of the **ARMv8-A (AArch64)** architecture executing natively on **Apple Silicon (M3 SoC)**. This project demonstrates proficiency in the AArch64 instruction set, memory-page alignment, and the Darwin (macOS) kernel syscall interface.

## 🎯 Technical Objectives
* **Instruction Set Mastery:** Implementing a native "Hello World" using raw AArch64 assembly without standard C libraries.
* **Kernel Interfacing:** Utilizing the `X16` register for Darwin-specific syscall numbering and `svc #0x80` for kernel traps.
* **Memory Addressing:** Implementing the `ADRP` (Address Page) and `ADD` (Page Offset) sequence required for 64-bit PC-relative addressing.

## 🔬 Architectural Key Findings
Unlike AArch64 Linux, which typically uses the `X8` register for syscall numbers and `svc #0` for traps, this study identifies and implements the specific requirements for the **Apple M3/Darwin kernel**:
* **Syscall Mapping:** `write` is mapped to syscall `#4` and `exit` to `#1`.
* **Register Convention:** Leveraging 64-bit general-purpose registers (`X0-X2`) for argument passing to the kernel.

## 🛠 Build & Execution
```bash
# Assemble and Link using native macOS tools
as -o hello.o hello.s
ld -o hello hello.o -lSystem -syslibroot $(xcrun --show-sdk-path) -e _main
./hello
