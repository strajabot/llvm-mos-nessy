#include "../h/hw.h"

#include "../h/string.h"

void clear_bss()
{
    char* bss_start = (char*)&__bss_start;
    unsigned short bss_size = (unsigned short)&__bss_size;
    memset(bss_start, 0, bss_size);  

    char* zp_bss_start = (char*)&__zp_bss_start;
    unsigned short zp_bss_size = (unsigned short)&__zp_bss_size;
    memset(zp_bss_start, 0, zp_bss_size);
}

void copy_data()
{
    char* data_start = (char*)&__data_start;
    unsigned short data_size = (unsigned short)&__data_size;
    char* data_load_start = (char*)&__data_load_start;
    memcpy(data_start, data_load_start, data_size);

    char* zp_data_start = (char*)&__zp_data_start;
    unsigned short zp_data_size = (unsigned short)&__zp_data_size;
    char* zp_data_load_start = (char*)&__zp_data_load_start;
    memcpy(zp_data_start, zp_data_load_start, zp_data_size);
}

void init_array()
{
    typedef void (*init_func)(void);
    init_func* init_array_start = (init_func*)&__init_array_start;
    init_func* init_array_end = (init_func*)&__init_array_end;
    
    for (init_func* func = init_array_start; func != init_array_end; func++)
    (*func)();
}

void fini_array()
{
     typedef void (*fini_func)(void);
    fini_func* fini_array_start = (fini_func*)&__fini_array_start;
    fini_func* fini_array_end = (fini_func*)&__fini_array_end;
    
    for (fini_func* func = fini_array_start; func != fini_array_end; func++)
    (*func)();
}
