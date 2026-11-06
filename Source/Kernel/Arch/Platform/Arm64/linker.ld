SECTIONS
{
    . = 0x40000000; /* Standard QEMU virt base address */
    .text : {
        KEEP(*(.text.boot))
        *(.text)
    }
    .rodata : { *(.rodata) }
    .data : { *(.data) }
    __bss_start = .;
    .bss : {
        *(.bss)
        *(COMMON)
    }
    __bss_end = .;
    . = ALIGN(16);
    . += 0x1000; /* 4KB stack */
    stack_top = .;
}
