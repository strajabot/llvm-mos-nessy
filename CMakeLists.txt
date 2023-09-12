platform(nes PARENT common)

if(NOT CMAKE_CROSSCOMPILING)
  return()
endif()

install(FILES
TYPE INCLUDE)
install(FILES
  c-in-ram.ld
  nes.ld
  prg-ram-fixed.ld
  prg-rom-fixed.ld
TYPE LIB)

add_platform_object_file(nes-crt0-o crt0.o crt0.c ines.s)

add_platform_library(nes-crt0)
merge_libraries(nes-crt0
  common-copy-data
  common-init-stack
  common-zero-bss
  common-exit-loop
)
