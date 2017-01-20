# Makefile for boot-r

MAKE=make
IMPORT=import

outputs=$(IMPORT)

.PHONY: all $(outputs)
all: $(outputs)

$(outputs):
	$(MAKE) --directory $@
