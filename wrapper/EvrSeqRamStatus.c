/**
@file
EvrSeqRamStatus <evr-device> <ram> - Display EVR Sequence RAM status.

@param <evr-device> Device name of EVR (defaults to /dev/era3) if left blank.
@param <ram> Sequence RAM number 0, 1
*/

#include <stdint.h>
#include <endian.h>
#include <byteswap.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <signal.h>
#include "../api/erapi.h"

/** @private */
int main(int argc, char *argv[])
{
  struct MrfErRers *pEr;
  int              fdEr;
  int              i;

  if (argc < 1)
    {
      printf("Usage: %s /dev/era3 <trig>\n", argv[0]);
      printf("Assuming: /dev/era3\n");
      argv[1] = "/dev/era3";
    }

  fdEr = EvrOpen(&pEr, argv[1]);
  if (fdEr == -1)
    return errno;

  if (argc > 2)
    {
      i = atoi(argv[2]);
      EvrSeqRamStatus(pEr, i);
    }
 
  EvrClose(fdEr);

  return 0;
}
