// hello.s — AArch64 assembly for macOS (Apple Silicon)
// Prints "Hello from raw assembly!\n" and exits cleanly.

.global _main
.align 4

_main:
    // write(1, msg, len)
    mov     x0, #1              // fd = stdout
    adrp    x1, msg@PAGE
    add     x1, x1, msg@PAGEOFF // pointer to string
    mov     x2, #27             // length of string
    mov     x16, #4             // syscall: write (macOS ARM64)
    svc     #0x80               // trap to kernel

    // exit(0)
    mov     x0, #0              // exit code 0
    mov     x16, #1             // syscall: exit
    svc     #0x80               // trap to kernel

.data
msg:
    .ascii "Hello from raw assembly!\n"
