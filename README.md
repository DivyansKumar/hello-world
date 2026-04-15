# Experiment : Hello World

**Goal:** Can Claude produce a minimal working program in AArch64 assembly?

**Result:** Yes, first try. 23 lines, compiled and ran immediately.

## What Claude Had to Get Right

- macOS uses `x16` for syscall numbers (not `x8` like Linux ARM64)
- Kernel trap is `svc #0x80` (not `svc #0` like Linux)
- Addresses must be loaded with a two-instruction `adrp`/`add` sequence (ARM64 can't encode a 64-bit address in one instruction)
- The `write` syscall is `#4`, `exit` is `#1` on macOS

## Build & Run

```bash
as -o hello.o hello.s
ld -o hello hello.o -lSystem -syslibroot $(xcrun --show-sdk-path) -e _main
./hello
```

## Output

```
Hello from raw assembly!
```

## Difficulty: Easy

This is a well-documented pattern, though macOS-specific syscall numbers and the `svc #0x80` trap are less commonly shown than their Linux equivalents.
