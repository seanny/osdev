.section ".text.boot"
.global _start

_start:
    mrs x0, mpidr_el1
    and x0, x0, #0xFF
    cbnz x0, 3f

    ldr x1, =stack_top
    mov sp, x1

    ldr x1, =__bss_start
    ldr x2, =__bss_end
    cmp x1, x2
    b.hs 1f
    str xzr, [x1], #8
    b 2b

    bl Arm64Init

    wfe
    b 3f
