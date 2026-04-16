// hello.s — AArch64 assembly for Apple M3 SoC
// Purpose: Demonstrate native system calls and register manipulation

.global _main
.align 4

_main:
    // --- Step 1: Architectural Logic (The "Senior Year" Addition) ---
    // We'll perform a simple shift to calculate a value, proving we can 
    // manipulate the 64-bit register file.
    mov     x10, #0x01          // Load immediate
    lsl     x10, x10, #4        // Logical Shift Left (0x01 -> 0x10)
    add     x10, x10, #0x05     // Result in X10 is 0x15

    // --- Step 2: System Call: write(1, msg, len) ---
    mov     x0, #1              // Argument 1: File descriptor (stdout)
    adrp    x1, msg@PAGE        // Load page address of 'msg'
    add     x1, x1, msg@PAGEOFF // Add offset within that page
    mov     x2, #27             // Argument 3: Length of string
    mov     x16, #4             // Darwin Syscall #4 (write)
    svc     #0x80               // Supervisor Call (Kernel Trap)

    // --- Step 3: System Call: exit(0) ---
    mov     x0, #0              // Argument 1: Exit code 0
    mov     x16, #1             // Darwin Syscall #1 (exit)
    svc     #0x80               // Supervisor Call

.data
msg:
    .ascii "Hello from raw assembly!\n"
