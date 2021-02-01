#include "screen.h"

int get_screen_offset(int col, int row)
{
    return (row * MAX_COLS + col) * 2;
}


//FIXME: It doesn't print a char after using clear screen
void print_char(char charater, int col, int row, char attributeByte){

    unsigned char *vidmem = (unsigned char *) VIDEO_ADDRESS;

    //If attribute isn't specified, then use default
    if(!attributeByte)
        attributeByte = WHITE_ON_BLACK;
    
    
    int offset;
    if(col >= 0 && row >= 0){
        offset = get_screen_offset(col, row);
    }else{
        offset = get_cursor();
    }

    //If there is a newline, set offset to the end of the current row, so it will be advanced to the first
    //col of the next row
    if(charater == '\n'){
        int rows = offset / (2*MAX_COLS);
        offset = get_screen_offset(1, rows);
    }else{
        vidmem[offset + 1] = charater;
        vidmem[offset] = attributeByte;
    }

    offset += 2;
    //offset = scroll(offset);
    set_cursor(offset);
}

int get_cursor()
{
    port_byte_out(REG_SCREEN_CTRL, 14);
    int offset = port_byte_in(REG_SCREEN_DATA) << 8;
    port_byte_out(REG_SCREEN_CTRL, 15);
    offset += port_byte_in(REG_SCREEN_DATA);
    return offset*2;
}

void set_cursor(int offset)
{
    offset /= 2;
    port_byte_out(REG_SCREEN_CTRL, 14);
    port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset >> 8));
    port_byte_out(REG_SCREEN_CTRL, 15);
    port_byte_out(REG_SCREEN_DATA, (unsigned char)(offset));
}


void print_at(char *message, int col, int row)
{
    if(col >= 0 && row >= 0)
        set_cursor(get_screen_offset(col, row));
    
    char c;
    int i = 0;
    while ( (c = message[i++]) != 0 )
    {
        print_char(c, col, row, WHITE_ON_BLACK);
    }

    // do
    // {
    //     c = message[i++];
    //     print_char(c, -1, -1, WHITE_ON_BLACK);
    // }while(c != '\0');
    
}

//FIXME: Doesn't print, need to test print at function
void print(char *message)
{
    print_at(message, -1, -1);
}

void clear_screen()
{
    int row = 0;
    int col = 0;

    for (row = 0; row < MAX_ROWS; row++)
    {
        for ( col = 0; col < MAX_COLS; col++)
        {
            print_char(' ', col, row, WHITE_ON_BLACK);
        }
        
    }
    set_cursor(get_screen_offset(0, 0));
}