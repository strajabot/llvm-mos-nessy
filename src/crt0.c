#define __NESSY__

int main()
{
    // init sp to ff 
    // init "__stack" at locations 0 and 1 to __stack
    // zero bss
    // zero zp bss
    // call main 
    // loop
    return 0;

}

// Establish trivial irq handler.
asm(".text\n"
    ".weak irq\n"
    "irq:\n"
    "  rti\n");

// Establish trivial irq handler.
asm(".text\n"
    ".weak nmi\n"
    "nmi:\n"
    "  rti\n");
