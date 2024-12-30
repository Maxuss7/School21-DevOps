#include "s21_cat.h"

#include <stdio.h>
#include <string.h>

int print_file(const char *filename, const char *flags) {
  FILE *file = fopen(filename, "r");
  if (file == NULL) {
    printf("cat: %s: No such file or directory\n", filename);
    return 1;
  }

  if (flags[0] == '-') {
    switch (flags[1]) {
      case 'b':
        number_print_b(file);
        break;
      case 'E':
        endline_print_E(file);
        break;
      case 'e':
        endline_print_e(file);
        break;
      case 'n':
        number_print_n(file);
        break;
      case 's':
        squeeze_print_s(file);
        break;
      case 'v':
        print_v(file);
        break;
      case 'T':
        tabulation_print(file);
        break;
      case 't':
        tabulation_v_print(file);
        break;
      default:
        printf("Flag \"%c\" does not exist\n", flags[1]);
        fclose(file);
        return 1;
    }
  } else {
    default_print(file);
  }

  fclose(file);
  return 0;
}

void print_v(FILE *file) {
  int c;
  while ((c = fgetc(file)) != EOF) {
    if (c == '\n' || c == '\t') {
      putchar(c);
    } else if (c != 9 && (c < 32 || c == 127)) {
      putchar('^');
      putchar((c == 127) ? '?' : c + 64);
    } else if (c >= 128 && c <= 159) {
      printf("M-^");
      putchar(c - 64);
    } else if (c > 159 && c < 255) {
      printf("M-");
      putchar(c - 128);
    } else if (c == 255) {
      printf("M-^?");
    } else {
      putchar(c);
    }
  }
}

void default_print(FILE *file) {
  char ch;
  while ((ch = fgetc(file)) != EOF) {
    putchar(ch);
  }
}

void squeeze_print_s(FILE *file) {
  char s[1024];
  int prev_line_empty = 0;
  while (fgets(s, sizeof(s), file)) {
    int current_line_empty = (strcmp(s, "\n") == 0);
    if (!current_line_empty || !prev_line_empty) {
      printf("%s", s);
    }
    prev_line_empty = current_line_empty;
  }
}

void number_print_b(FILE *file) {
  char s[1024];
  int i = 1;
  while (fgets(s, sizeof(s), file)) {
    if (strcmp(s, "\n") != 0) {
      printf("%6d\t%s", i, s);
      i++;
    } else {
      printf("%s", s);
    }
  }
}

void number_print_n(FILE *file) {
  char s[1024];
  int i = 1;
  while (fgets(s, 1024, file)) {
    printf("%6d\t%s", i, s);
    i++;
  }
}

void endline_print_e(FILE *file) {
  int c;
  while ((c = fgetc(file)) != EOF) {
    if (c == '\n') {
      putchar('$');
      putchar(c);
    } else if (c != 9 && (c < 32 || c == 127)) {
      putchar('^');
      putchar((c == 127) ? '?' : c + 64);
    } else if (c >= 128 && c <= 159) {
      printf("M-^");
      putchar(c - 64);
    } else if (c > 159 && c < 255) {
      printf("M-");
      putchar(c - 128);
    } else if (c == 255) {
      printf("M-^?");
    } else {
      putchar(c);
    }
  }
}

void endline_print_E(FILE *file) {
  int c;
  while ((c = fgetc(file)) != EOF) {
    if (c == '\n') {
      putchar('$');
    }
    putchar(c);
  }
}

void tabulation_print(FILE *file) {
  int c;
  while ((c = fgetc(file)) != EOF) {
    if (c == '\t') {
      printf("^I");
    } else {
      putchar(c);
    }
  }
}

void tabulation_v_print(FILE *file) {
  int c;
  while ((c = fgetc(file)) != EOF) {
    if (c == '\n') {
      putchar('\n');
    } else if ((c < 32 || c == 127)) {
      putchar('^');
      putchar((c == 127) ? '?' : c + 64);
    } else if (c >= 128 && c <= 159) {
      printf("M-^");
      putchar(c - 64);
    } else if (c > 159 && c < 255) {
      printf("M-");
      putchar(c - 128);
    } else if (c == 255) {
      printf("M-^?");
    } else {
      putchar(c);
    }
  }
}

int main(int argc, char *argv[]) {
  if (argc < 2) {
    printf("cat: No argument");
    return 1;
  } else if (argc > 3) {
    printf("cat: Too many arguments");
    return 1;
  } else if (argc == 2) {
    print_file(argv[1], "0");
  } else if (argc == 3) {
    if (!strcmp(argv[1], "--number-nonblank")) {
      strcpy(argv[1], "-b");
    } else if (!strcmp(argv[1], "--number")) {
      strcpy(argv[1], "-n");
    } else if (!strcmp(argv[1], "--squeeze-blank")) {
      strcpy(argv[1], "-s");
    }
    print_file(argv[2], argv[1]);
  }

  return 0;
}
