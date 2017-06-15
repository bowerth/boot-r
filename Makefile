# Makefile for boot-r

MAKE=make
IMPORT=import
RMD=_Rmd_files

outputs=$(IMPORT) $(RMD)

.PHONY: all $(outputs)
all: $(outputs)

$(outputs):
	$(MAKE) --directory $@
