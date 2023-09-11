$(shell if [ ! -f Makefile.user ]; then cp Makefile.user.example Makefile.user; fi)

-include Makefile.user

CC = $(LLVM_MOS_DIR)bin/mos-nes-clang
OC = $(LLVM_MOS_DIR)bin/llvm-objcopy
OD = $(LLVM_MOS_DIR)bin/llvm-objdump

ifeq ($(OS),Windows_NT)
  CC := $(CC).bat
endif

CFLAGS =
LDFLAGS = -L $(LLVM_MOS_DIR)mos-platform\nes-cnrom\lib -I$(LLVM_MOS_DIR)mos-platform\nes\lib 
LDFLAGS += -T link.ld -Wl,--defsym,__prg_rom_size=32,--defsym,__chr_rom_size=16,--defsym,__mapper=0 
LDFLAGS += -nostdlib

all: libcrt0.a

libcrt0.a: crt0.c
	$(CC) $(CFLAGS) -c -o crt0.o crt0.c
	$(CC) $(LDFLAGS) -o libcrt0.a crt0.o ines.s
