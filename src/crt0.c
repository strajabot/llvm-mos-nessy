#define __NESSY__

// Set up the hardware stack and launch early initialization.
asm(".section .init\n"
    "  sei\n"
    "  ldx #$ff\n"
    "  txs\n"
    "  jsr init\n");

void init()
{
    // init sp to ff 
    // init "__stack" at locations 0 and 1 to __stack
    // zero bss
    // zero zp bss
    // call main 
    // loop
}

// Establish trivial irq handler.
asm(".text\n"
    ".weak irq\n"
    "irq:\n"
    "  rti\n");

// Establish default nmi handler prologue and epilogue.
asm(".section .nmi_begin,\"axG\",@progbits,nmi\n"
    ".weak nmi\n"
    ".globl __default_nmi\n"
    "nmi:\n"
    "__default_nmi:\n"
    "  pha\n"
    "  txa\n"
    "  pha\n"
    "  tya\n"
    "  pha\n"

    ".section .nmi_end,\"axG\",@progbits,nmi\n"
    "  pla\n"
    "  tay\n"
    "  pla\n"
    "  tax\n"
    "  pla\n"
    "  rti\n");
