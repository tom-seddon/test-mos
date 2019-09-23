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
* `A00` - ACIA status register
* `a00` - ADC status register
* `Fxx` - FDC registers: 00=status, 01=track, 02=sector, 03=data,
  04=drive control
* `V` - time between vsyncs in initial CRTC state, or `0000` if no
  vsync detected

(On my Master, ACCCON starts out with TST=1, so the I/O is paged out.
If the ACCCON result is reliably `FF`, it's probably bogus.)

A constantly changing character in the bottom right shows that there
are no IRQs occurring - the IRQ handler is an infinite loop.

# Results from my Master

## CPU

* A=$00, X=$00, Y=$00
* P=$36 (U=1, B=1, I=1, Z=1)
* S=$FD

## Paging

* ROMSEL: $8F (ANDY=1, ROM=15)

* ACCCON (inferred from some experimentation): IRR=1, TST=1, Y=1, X=1, D=1

	Presumably E=1 too, then, but with TST=1 and Y=1 it's rather hard
    to say.

	I don't have any easy way of testing whether IFJ=1.

## CRTC

* R12,R13 = $0000
* R14,R15 = $0000
* R16,R17 = random

The time between vsyncs with the initial state seems very variable,
and there are often no vsyncs at all. I'm assuming for now that the
other register values are all random.

## System VIA, User VIA

* DDRx = $00
* T1L = random? (T1L-H seems to be typically $00 though)
* T2L = random? (inferred from T2 counter values being rather variable)
* SR = random
* ACR = $00
* PCR = $00
* IFR = $00
* IER = $80

## ACIA

* Status register = random

## ADC

* Status register = random

## FDC

All registers seem to be random.
