# -*- mode: makefile-gmake -*-

.PHONY:all
all:
	64tass --flat --m65c02 --nostart -Wall -C --line-numbers -Ltest-mos.lst main.s65
	@dd if=/dev/zero conv=notrunc of=blank.out bs=16384 count=7
	@cat a.out blank.out > test-mos.rom
	@ls -l test-mos.rom
