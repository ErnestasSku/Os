unsigned char PortByteIn(unsigned short port){
    
    //A function which reads a byte from a specified port
    // "=a" (result): Puts al register in variable result when finishes
    // "d" (port): leads EDX with port 
    unsigned char result;
    __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
    return result;
}

void PortByteOut(unsigned short port, unsigned char data){
    // "a" (data): loads EAX with data
    // "d" (port): loads EDX with port
    __asm__("out %%al, %%dx" : :"a" (data), "d" (port));
}

unsigned short PortWordIn(unsigned short port){
    unsigned short result;
    __asm__("in %%dx, %%ax" : "=a" (result) : "d" (port));
    return result;
}

void PortWordOut(unsigned short port, unsigned short data){
    __asm__("out %%ax, %%dx" : : "a" (data), "d" (port));
}