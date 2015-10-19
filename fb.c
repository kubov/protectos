#include "fb.h"

uint16_t  *_fb = (uint16_t*)0xb8000;

void fb_write(uint32_t i, char c, uint8_t fg, uint8_t bg)
{
  _fb[i] = ((fg | bg) << 8) | c;
}
