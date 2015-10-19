#include "io.h"

void out(uint16_t port, uint8_t val)
{
   __asm__ __volatile__ ("mov %0, %%dx;"
       "mov %1, %%al;"
       "out %%al, %%dx"
       :
       : "r"(port), "r"(val)
       : "dx", "al");
}
