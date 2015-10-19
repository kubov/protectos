#include "fb.h"
#include "io.h"

uint16_t  *_fb = (uint16_t*)0xb8000;
uint16_t _pos = 0;

void fb_set_cell(uint32_t i, char c, uint8_t fg, uint8_t bg)
{
    _fb[i] = ((fg | bg) << 8) | c;
}

void fb_clear()
{
    _pos = 0;

    for (int i=0; i< FB_WIDTH*FB_HEIGHT; i++)
        fb_set_cell(i, ' ', FB_BLACK, FB_BLACK);
}

void fb_move(uint16_t pos)
{
    out(FB_COMMAND_PORT, FB_HIGH_BYTE_COMMAND);
    out(FB_DATA_PORT, ((pos >> 8) & 0xff));
    out(FB_COMMAND_PORT, FB_LOW_BYTE_COMMAND);
    out(FB_DATA_PORT, pos & 0xff);
}

void fb_write_char(char c)
{
    uint8_t draw = 1;
    if (c == '\n')
    {
        _pos += FB_WIDTH - (_pos % FB_WIDTH);
        draw = 0;
    }
    else
    {
        fb_set_cell(_pos, c, FB_BLACK, FB_GREEN);
        _pos += 1;
    }

    fb_move(_pos);
}

void fb_write(char* buf, int len)
{
    for (int i=0; i<len; i++)
        fb_write_char(buf[i]);
}

void fb_write_str(char* buf)
{
    while(*buf) fb_write_char(*buf++);
}
