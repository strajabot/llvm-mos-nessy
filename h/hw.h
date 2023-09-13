#ifndef HW_H
#define HW_H

extern char __bss_start;
extern char __bss_size;

extern char __zp_bss_start;
extern char __zp_bss_size;

extern char __data_start;
extern char __data_size;
extern char __data_load_start;

extern char __zp_data_start;
extern char __zp_data_size;
extern char __zp_data_load_start;

extern char __init_array_start; 
extern char __init_array_end;

extern char __fini_array_start;
extern char __fini_array_end;

#endif //!HW_H
