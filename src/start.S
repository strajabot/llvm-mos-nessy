
.globl _start
_start:
    ; Load 0xFF into the SP register
    sei
    ldx #$ff
    txs
    ; Load 0x800 into imaginary register 0 (aditional SP) 
    lda #$00
    sta __rc0
    lda #$08
    sta __rc1
    ; Write 0x00 to .bss sections 
    ; jsr write_zero_bss;
    ; Fill .data sections
    ; jsr copy_data;
    jsr main;
_exit:
    jmp _exit;
