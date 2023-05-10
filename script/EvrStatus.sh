#!/bin/bash

FREQ_CMD=/opt/epics7/modules/mrfioc2/bin/linux-x86_64/FracSynthAnalyze
WRAP_DIR=../wrapper
VALID_EVRS="[c]"

if [[ $# -ne 1 ]]; then
	echo "Usage: $0 <evr>"
	exit 1
fi

EVR=$1
if [[ ! $EVR =~ \/dev\/er${VALID_EVRS}3 ]]; then
	echo "The only valid EVR names are /dev/er${VALID_EVRS}3"
	exit 1
fi

echo ""
echo "============================================================================================"
echo "Status Dump:"
echo "============================================================================================"
$WRAP_DIR/EvrDumpStatus $EVR

echo ""
echo "============================================================================================"
echo "Fractional Divider:"
echo "============================================================================================"
FD_WORD=$($WRAP_DIR/EvrGetFracDiv $EVR)
$FREQ_CMD $FD_WORD

echo ""
echo "============================================================================================"
echo "Clock Control Register:"
echo "============================================================================================"
$WRAP_DIR/EvrGetClockControl $EVR

echo ""
echo "============================================================================================"
echo "Event Mapping RAMs:"
echo "============================================================================================"
# TODO: Determine which RAM is currently active and only display that one
echo "RAM 0"
$WRAP_DIR/EvrDumpMapRam $EVR 0

echo ""
echo "RAM 1"
$WRAP_DIR/EvrDumpMapRam $EVR 1

echo ""
echo "============================================================================================"
echo "Sequence RAMs:"
echo "============================================================================================"
# TODO: Determine which RAM is currently active and only display that one
echo "RAM 0"
$WRAP_DIR/EvrSeqRamDump $EVR 0

echo ""
echo "RAM 1"
$WRAP_DIR/EvrSeqRamDump $EVR 1

echo ""
echo "============================================================================================"
echo "Pulse Generators:"
echo "============================================================================================"
$WRAP_DIR/EvrDumpPulses $EVR


