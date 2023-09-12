
__rc0 = 0x00;
INCLUDE imag-regs.ld

MEMORY {
  zero_page : ORIGIN = __rc31 + 1, LENGTH = 0x100 - (__rc31 + 1)
  ram : ORIGIN = 0x200, LENGTH = 0x1e00;
  prg_rom : ORIGIN = 0x8000, LENGTH = 0x4000;
}

REGION_ALIAS("c_rom", prg_rom)
REGION_ALIAS("c_rom", ram)

__stack = 0x800;

SECTIONS {
  .text : {
    _init = .;
    _start = .;
    *(.init)
    *(.init.*)
    
    *(.call_main)
    *(.after_main)

    _fini=.;
    *(.fini)
    *(.fini.*)
    *(.fini_rts)

    *(.text)
    *(.text.*)
    
    /* A sorted list of initialization function pointers. Used for GCC
    * constructor attribute and C++ global constructors. */
    __init_array_start = .;
    KEEP (*(SORT_BY_INIT_PRIORITY(.init_array.* .init_array)))
    __init_array_end = .;

    /* A sorted list of finalization function pointers. Used for GCC destructor
    * attribute. */
    __fini_array_start = .;
    KEEP (*(SORT_BY_INIT_PRIORITY(.fini_array.* .fini_array)))
    __fini_array_end = .;


  } >c_readonly

  .rodata : {
    *(.rodata)
    *(.rodata.*)
  } >c_readonly
  
  .data : {
    __data_start = .;
    *(.data)
    *(.data.*)
    __data_end = .;

  } >c_writeable AT>c_readonly
  __data_load_start = LOADADDR(.data);
  __data_size = SIZEOF(.data);

  .zp.data : {
    __zp-data_start = .;
    *(.zp.data)
    *(.zp.data.*)
    *(.zp.rodata)
    *(.zp.rodata.*)


  } >zp AT>c_readonly
  __zp_data_load_start = LOADADDR(.zp.data);
  __zp_data_size = SIZEOF(.zp.data);
  
  .zp.bss (NOLOAD) : {
    __zp_bss_start = .;
    *(.zp.bss)
    *(.zp.bss.*)
  } >zp
  __zp_bss_size = SIZEOF(.zp.bss);

  .zp (NOLOAD) : {
    *(.zp)
    *(.zp.*)
    *(.zeropage)
    *(.zeropage.*)
    *(.directpage)
    *(.directpage.*)
  } >zp

  .bss (NOLOAD) : {
    __bss_start = .;
    *(.bss)
    *(.bss.*)
    *(COMMON)
    __bss_end = .;
    
  } >c_writeable
  __bss_size = SIZEOF(.bss);
  
  .noinit (NOLOAD) : {
    *(.noinit)
    *(.noinit.*)
    __heap_start = .;
  } >c_writeable
    
  .prg_rom_fixed : { *(.prg_rom_fixed .prg_rom_fixed.*) } >prg_rom
 
  .vector 0xfffa : { SHORT(nmi) SHORT(_start) SHORT(irq) } >prg_rom
}

OUTPUT_FORMAT {
  


}


