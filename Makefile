# -*- mode: makefile-gmake -*-
##########################################################################
##########################################################################

BUILD:=build

##########################################################################
##########################################################################

.PHONY:all
all:
	mkdir -p $(BUILD)
	64tass --flat --m65c02 --nostart -Wall -C --line-numbers --output=$(BUILD)/test_mos.out --list=$(BUILD)/test_mos.lst test_mos.s65
	@dd if=/dev/zero conv=notrunc of=$(BUILD)/blank.out bs=16384 count=7
	@cat $(BUILD)/test_mos.out $(BUILD)/blank.out > $(BUILD)/test_mos.rom
	@ls -l $(BUILD)/test_mos.rom

.PHONY:program
program:
	python ./submodules/beeb/mos_program.py 7 $(BUILD)/test_mos.rom
