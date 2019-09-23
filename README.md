# Test MOS

Test MOS for the Master 128. Shows the power-on state of some of the
hardware.

# Building

Prerequisites:

- OS X
- 64tass

Run `make`.

The resulting 128 KByte MegaROM image is in `build/test_mos.rom`.

When programmed into a Master, it produces a screenful of Mode 7 text
on boot.

# Interpreting the results

The output is a sequence of `NAME=VALUE` readings, with the names as
follows:

* `Mxx` - CPU, where `xx` indicates the register: 00=A, 01=X, 02=Y,
  03=P, 04=S
* `Cxx` - CRTC, where `xx` is the (hex) register number (most are
  write-only, so these values are junk)
* `Sxx`, `Uxx` - System/User VIA, where `xx` is the (hex) register number
* `Pxx` - paging, where `xx` indicates the register: 00=ROMSEL, 01=ACCCON

On my Master, ACCCON starts out with TST=1, so the I/O is paged out.
If the ACCCON result is reliably `FF`, it's probably bogus.

# Results from my Master

## CPU

* A=$00, X=$00, Y=$00
* P=$36 (U=1, B=1, I=1, Z=1)
* S=$FD

## Paging

* ROMSEL: $8F (ANDY=1, ROM=15)

* ACCCON (inferred from some experimentation): TST=1, Y=1, X=1, D=1

	I suspect E=1 too, but with TST=1 and Y=1 it's rather hard to say.

	I don't have any easy way of testing whether IFJ=1.

	If IRR=1 on startup, it seems to have no effect - the IRQ routine
    is an infinite loop.

## CRTC

* R12,R13 = $0000
* R14,R15 = $0000
* R16,R17 = random

## System VIA, User VIA

* DDRx = $00
* T1L = $0000
* T2L = random? (T2 counter values seem variable)
* SR = random
* ACR = $00
* PCR = $00
* IFR = $00
* IER = $80
