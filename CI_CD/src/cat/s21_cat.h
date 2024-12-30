#ifndef PRINT_FILE_H
#define PRINT_FILE_H

#include <stdio.h>

int print_file(const char *filename, const char *flag);
void default_print(FILE *file);
void number_print_b(FILE *file);
void endline_print_e(FILE *file);
void endline_print_E(FILE *file);
void number_print_n(FILE *file);
void squeeze_print_s(FILE *file);
void print_v(FILE *file);
void tabulation_print(FILE *file);
void tabulation_v_print(FILE *file);

#endif