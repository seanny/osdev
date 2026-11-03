/*
 * Core design:
 * generic_startup is called as soon as the platform has finished its main code
 */

// Generic Main called after Arch-specific startup code
void GenericMain()
{
    kernel_puts("Hello World");
}