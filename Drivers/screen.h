#ifndef SCREEN_H
#define SCREEN_H

#define VIDEO_ADDRESS 0xb8000
#define MAX_ROWS 25
#define MAX_COLS 80

//TextColor
#define WHITE_ON_BLACK 0x0f

//Screen I/O ports
#define REG_SCREEN_CTRL 0x3D4
#define REG_SCREEN_DATA 0x3D5

int get_screen_offset(int col, int row);
void set_cursor(int offset);
int get_cursor();
int scroll();

void print_at(char *message, int col, int row);
void print_char(char charater, int col, int row, char attributeByte);
void clear_screen();

#endif