#pragma once
#include "protectos.h"

#define FB_BLACK 0
#define FB_WHITE 15
#define FB_GREEN 10

void fb_write(uint32_t i, char c, uint8_t fg, uint8_t bg);

