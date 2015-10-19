#pragma once
#include "protectos.h"

#define FB_BLACK 0
#define FB_WHITE 15
#define FB_GREEN 10

#define FB_COMMAND_PORT         0x3D4
#define FB_DATA_PORT            0x3D5
#define FB_HIGH_BYTE_COMMAND    14
#define FB_LOW_BYTE_COMMAND     15

#define FB_WIDTH 80
#define FB_HEIGHT 25

void fb_set_cell(uint32_t i, char c, uint8_t fg, uint8_t bg);
void fb_write_char(char c);
void fb_write(char* buf, int len);
void fb_clear();
void fb_write_str(char* buf);
