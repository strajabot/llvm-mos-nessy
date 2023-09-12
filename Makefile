$(shell if [ ! -f Makefile.user ]; then cp Makefile.user.example Makefile.user; fi)

-include Makefile.user

CC = $(LLVM_MOS_DIR)bin/mos-clang
OC = $(LLVM_MOS_DIR)bin/llvm-objcopy
OD = $(LLVM_MOS_DIR)bin/llvm-objdump

ifeq ($(OS),Windows_NT)
  CC := $(CC).bat
endif

CFLAGS = -Os
LDFLAGS += -T link.ld -Wl 
LDFLAGS += -nostdlib -v

all: libcrt0.a

libcrt0.a: src/crt0.c src/start.S
	$(CC) $(CFLAGS) -c -o crt0.o src/crt0.c
	$(CC) $(LDFLAGS) -o libcrt0.a crt0.o src/start.S
