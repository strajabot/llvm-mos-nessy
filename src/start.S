
.weak _start
_start:
    ; Load 0xFF into the SP register
    sei
    ldx #$ff
    txs
    ; Load 0x800 into imaginary register 0 (aditional SP) 
    lda #mos16lo(__stack)
    sta __rc0
    lda #mos16hi(__stack)
    sta __rc1
    ; Write 0x00 to .bss sections 
    jsr clear_bss
    ; Fill .data sections
    jsr copy_data
    ; GCC constructors
    jsr init_array
    ; Call main function
    jsr main
    ; GCC destructors
    jsr fini_array
.weak _exit
_exit:
    jmp _exit
