$(shell if [ ! -f Makefile.user ]; then cp Makefile.user.example Makefile.user; fi)

-include Makefile.user

AR = $(LLVM_MOS_DIR)bin/llvm-ar
CC = $(LLVM_MOS_DIR)bin/mos-clang
OC = $(LLVM_MOS_DIR)bin/llvm-objcopy
OD = $(LLVM_MOS_DIR)bin/llvm-objdump

CFLAGS = -Os
LDFLAGS += -T link.ld
LDFLAGS += -nostdlib -v

all: libcrt0.a

libcrt0.a: src/crt0.c src/start.S
	mkdir -p obj
	$(CC) $(CFLAGS) -c -o obj/crt0.o src/crt0.c
	$(CC) $(CFLAGS) -c -o obj/start.o src/start.S
	$(AR) rc libcrt0.a obj/crt0.o obj/start.o

clean :
	rm -rf obj libcrt0.a
