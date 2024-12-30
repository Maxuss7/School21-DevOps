
#include <regex.h>
#include <stdio.h>
#include <string.h>

#define MAX_LINE_LENGTH 2048
#define MAX_PATTERNS 100
#define MAX_PATTERN_LENGTH 100

int matches_pattern(char *line, char *pattern, int ignore_case) {
  regex_t regex;
  int reti;
  int cflags = REG_EXTENDED | (ignore_case ? REG_ICASE : 0);

  reti = regcomp(&regex, pattern, cflags);
  if (reti) {
    char err_buf[100];
    regerror(reti, &regex, err_buf, sizeof(err_buf));
    fprintf(stderr, "Ошибка компиляции регулярного выражения: %s\n", err_buf);
    return 0;
  }

  reti = regexec(&regex, line, 0, NULL, 0);
  regfree(&regex);
  return reti == 0;
}

void print_only_matches_func(char *line, char *pattern, int ignore_case) {
  regex_t regex;
  regmatch_t pmatch[1];
  int cflags = REG_EXTENDED | (ignore_case ? REG_ICASE : 0);

  if (regcomp(&regex, pattern, cflags) != 0) {
    return;
  }

  char *pos = line;
  while (regexec(&regex, pos, 1, pmatch, 0) == 0) {
    printf("%.*s\n", (int)(pmatch[0].rm_eo - pmatch[0].rm_so),
           pos + pmatch[0].rm_so);
    pos += pmatch[0].rm_eo;
  }

  regfree(&regex);
}

void print_matched_line(char *filename, char *line, int line_number,
                        int print_filename, int print_line_number,
                        int print_only_matches, char *pattern,
                        int ignore_case) {
  if (print_only_matches) {
    print_only_matches_func(line, pattern, ignore_case);
    return;
  }

  if (filename && print_filename) printf("%s:", filename);
  if (print_line_number) printf("%d:", line_number);
  int line_length = strlen(line);
  if (line[line_length - 1] != '\n') {
    line[line_length] = '\n';
    line[line_length + 1] = '\0';
  }
  printf("%s", line);
}

void add_patterns_from_file(char *filename, char patterns[][MAX_PATTERN_LENGTH],
                            int *pattern_count) {
  FILE *file = fopen(filename, "r");
  if (file == NULL) {
    printf("grep: %s: No such file or directory\n", filename);
    return;
  }

  char line[MAX_LINE_LENGTH];
  while (fgets(line, MAX_LINE_LENGTH, file) != NULL) {
    size_t len = strlen(line);
    if (len > 0 && line[len - 1] == '\n') {
      line[len - 1] = '\0';
    }
    strcpy(patterns[(*pattern_count)++], line);
  }

  fclose(file);
}

void grep_file(char *filename, char patterns[][MAX_PATTERN_LENGTH],
               int pattern_count, int ignore_case, int invert_match,
               int print_count, int print_filenames, int print_line_numbers,
               int suppress_errors, int print_only_matches,
               int print_matching_files, int is_multifile) {
  FILE *file = fopen(filename, "r");
  if (file == NULL) {
    if (!suppress_errors)
      printf("grep: %s: No such file or directory\n", filename);
    return;
  }

  char line[MAX_LINE_LENGTH];
  int line_number = 0;
  int match_count = 0;

  while (fgets(line, MAX_LINE_LENGTH, file) != NULL) {
    line_number++;
    int match = 0;
    for (int i = 0; i < pattern_count; i++) {
      if (matches_pattern(line, patterns[i], ignore_case)) {
        match = 1;
        break;
      }
    }
    if ((match && !invert_match) || (!match && invert_match)) {
      match_count++;
      if (!print_count && !print_matching_files) {
        if (is_multifile && print_filenames) {
          print_matched_line(filename, line, line_number, 1, print_line_numbers,
                             print_only_matches, patterns[0], ignore_case);
        } else {
          print_matched_line(NULL, line, line_number, 0, print_line_numbers,
                             print_only_matches, patterns[0], ignore_case);
        }
      }
      if (print_matching_files) {
        printf("%s\n", filename);
        break;
      }
    }
  }

  if (print_count) {
    if (is_multifile) printf("%s:", filename);
    printf("%d\n", match_count);
  }

  fclose(file);
}

int main(int argc, char *argv[]) {
  int return_code = 0;  // Переменная для хранения кода возврата

  if (argc < 3) {
    printf("Usage: %s [OPTIONS] pattern file1 [file2 ...]\n", argv[0]);
    return_code = 1;
  } else {
    char patterns[MAX_PATTERNS][MAX_PATTERN_LENGTH];
    int pattern_count = 0;

    int ignore_case = 0;
    int invert_match = 0;
    int print_count = 0;
    int print_filenames = 1;
    int print_line_numbers = 0;
    int suppress_errors = 0;
    int print_only_matches = 0;
    int print_matching_files = 0;

    int file_index = 0;
    int pattern_provided = 0;

    for (int i = 1; i < argc; i++) {
      if (argv[i][0] == '-') {
        for (int j = 1; argv[i][j] != '\0'; j++) {
          switch (argv[i][j]) {
            case 'i':
              ignore_case = 1;
              break;
            case 'v':
              invert_match = 1;
              break;
            case 'c':
              print_count = 1;
              break;
            case 'l':
              print_matching_files = 1;
              break;
            case 'n':
              print_line_numbers = 1;
              break;
            case 's':
              suppress_errors = 1;
              break;
            case 'o':
              print_only_matches = 1;
              break;
            case 'h':
              print_filenames = 0;
              break;
            case 'e':
              if (argv[i][j + 1] == '\0') {
                i++;
                if (i < argc) {
                  if (pattern_count < MAX_PATTERNS) {
                    strcpy(patterns[pattern_count++], argv[i]);
                    pattern_provided = 1;
                  } else {
                    printf("grep: Too many patterns (maximum is %d)\n",
                           MAX_PATTERNS);
                    return_code = 1;
                  }
                } else {
                  printf("grep: Missing pattern after -e flag\n");
                  return_code = 1;
                }
              } else {
                if (pattern_count < MAX_PATTERNS) {
                  strcpy(patterns[pattern_count++], &argv[i][j + 1]);
                  pattern_provided = 1;
                } else {
                  printf("grep: Too many patterns (maximum is %d)\n",
                         MAX_PATTERNS);
                  return_code = 1;
                }
              }
              j = strlen(argv[i]) - 1;
              break;
            case 'f':
              if (argv[i][j + 1] == '\0') {
                i++;
                if (i < argc) {
                  add_patterns_from_file(argv[i], patterns, &pattern_count);
                  pattern_provided = 1;
                } else {
                  fprintf(stderr, "s21_grep: Missing file after -f flag\n");
                  return_code = 1;
                }
              } else {
                add_patterns_from_file(&argv[i][j + 1], patterns,
                                       &pattern_count);
                pattern_provided = 1;
              }
              j = strlen(argv[i]) - 1;
              break;
            default:
              fprintf(stderr, "s21_grep: Unknown option %c\n", argv[i][j]);
              return_code = 1;
          }
        }
      } else {
        if (!pattern_provided) {
          if (pattern_count < MAX_PATTERNS) {
            strcpy(patterns[pattern_count++], argv[i]);
            pattern_provided = 1;
          } else {
            fprintf(stderr, "s21_grep: Too many patterns (maximum is %d)\n",
                    MAX_PATTERNS);
            return_code = 1;
          }
        } else {
          file_index = i;
          break;
        }
      }
    }

    if (file_index == 0) {
      fprintf(stderr, "s21_grep: No files provided\n");
      return_code = 1;
    } else {
      int is_multifile = argc - file_index > 1;
      for (int i = file_index; i < argc; i++) {
        grep_file(argv[i], patterns, pattern_count, ignore_case, invert_match,
                  print_count, print_filenames, print_line_numbers,
                  suppress_errors, print_only_matches, print_matching_files,
                  is_multifile);
      }
    }
  }

  return return_code;
}
