SHELL := /bin/bash
CC = gcc

CCFLAGS = -Wall -Wextra -Werror -std=c11

TARGET = s21_cat
CAT_SRC = s21_cat.c

all: clang s21_cat

s21_cat: s21_cat.o
	$(CC) $(CCFLAGS) s21_cat.o -lm -o $(TARGET)
	  

s21_cat.o: $(CAT_SRC)
	$(CC) $(CCFLAGS) $(CAT_SRC) -c 

clean:
	rm -f $(TARGET)
	rm -f $(TARGET).o

clang:
	clang-format -style=Google -i s21_cat.c s21_cat.h

test: 
	@echo "------------------TEST#1 Default Print------------------"
	@-diff <(./$(TARGET) test_file.txt) <(cat test_file.txt) -s

	@echo "------------------TEST#2 Number Non-blank (-b)------------------"
	@-diff <(./$(TARGET) -b test_file.txt) <(cat -b test_file.txt) -s
	@-diff <(./$(TARGET) --number-nonblank test_file.txt) <(cat --number-nonblank test_file.txt) -s

	@echo "------------------TEST#3 Show End-of-line (-E)------------------"
	@-diff <(./$(TARGET) -E test_file.txt) <(cat -E test_file.txt) -s

	@echo "------------------TEST#4 Show End-of-line (-e)------------------"
	@-diff <(./$(TARGET) -e test_file.txt) <(cat -e test_file.txt) -s
	@-diff <(./$(TARGET) -e test_special_chars.txt) <(cat -e test_special_chars.txt) -s

	@echo "------------------TEST#5 Number All Lines (-n)------------------"
	@-diff <(./$(TARGET) -n test_file.txt) <(cat -n test_file.txt) -s

	@echo "------------------TEST#6 Squeeze Blank (-s)------------------"
	@-diff <(./$(TARGET) -s test_file.txt) <(cat -s test_file.txt) -s
	@-diff <(./$(TARGET) --squeeze-blank test_file.txt) <(cat --squeeze-blank test_file.txt) -s

	@echo "------------------TEST#7 Non-printing Characters (-v)------------------"
	@-diff <(./$(TARGET) -v test_special_chars.txt) <(cat -v test_special_chars.txt) -s
	@-diff <(./$(TARGET) -v test_file.txt) <(cat -v test_file.txt) -s


	@echo "------------------TEST#8 Tab Display (-T)------------------"
	@-diff <(./$(TARGET) -T test_file.txt) <(cat -T test_file.txt) -s
	@-diff <(./$(TARGET) -T test_special_chars.txt) <(cat -T test_special_chars.txt) -s

	@echo "------------------TEST#9 Tab and Non-printing Characters (-t)------------------"
	@-diff <(./$(TARGET) -t test_file.txt) <(cat -t test_file.txt) -s
	@-diff <(./$(TARGET) -T test_special_chars.txt) <(cat -T test_special_chars.txt) -s

