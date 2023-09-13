$(shell if [ ! -f Makefile.user ]; then cp Makefile.user.example Makefile.user; fi)

-include Makefile.user

SRCDIR = src
OBJDIR = obj

AR = $(LLVM_MOS_DIR)bin/llvm-ar
CC = $(LLVM_MOS_DIR)bin/mos-clang
OC = $(LLVM_MOS_DIR)bin/llvm-objcopy
OD = $(LLVM_MOS_DIR)bin/llvm-objdump

CFLAGS = -Os
LDFLAGS += -T link.ld
LDFLAGS += -nostdlib

all: libcrt0.a

OBJECTS =

SOURCES_S = $(shell find ${SRCDIR} -name "*.S" -printf "%P ")
OBJECTS += $(addprefix ${OBJDIR}/,${SOURCES_S:.S=.o})
vpath %.S $(sort $(dir ${SOURCES_S}))

SOURCES_C = $(shell find ${SRCDIR} -name "*.c" -printf "%P ")
OBJECTS += $(addprefix ${OBJDIR}/,${SOURCES_C:.c=.o})
vpath %.c $(sort $(dir ${SOURCES_C}))

SOURCES_CC = $(shell find ${SRCDIR} -name "*.cc" -printf "%P ")
OBJECTS += $(addprefix ${OBJDIR}/,${SOURCES_CC:.cc=.o})
vpath %.cc $(sort $(dir ${SOURCES_CC}))

vpath %.c $(SRCDIR)/$(TARGETLIST) $(SRCDIR)

$(OBJDIR)/%.o: %.c
	mkdir -p $(dir $@)
	$(CC) -c $(CFLAGS) -o $@ $<


vpath %.cc $(SRCDIR)/$(TARGETLIST) $(SRCDIR)

$(OBJDIR)/%.o: %.cc
	mkdir -p $(dir $@)
	$(CC) -c $(CFLAGS) -o $@ $<

vpath %.S $(SRCDIR)/$(TARGETLIST) $(SRCDIR)

$(OBJDIR)/%.o: %.S
	mkdir -p $(dir $@)
	$(CC) -c $(ASFLAGS) -o $@ $<



libcrt0.a: $(OBJECTS)
	$(AR) rc libcrt0.a $^

publish: libcrt0.a
	cp libcrt0.a ../nessy-gamedev/target/nessy/lib/libcrt0.a
	cp *.ld ../nessy-gamedev/target/nessy/lib/
	cp -r h ../nessy-gamedev/target/nessy/

clean:
	rm -rf obj libcrt0.a
