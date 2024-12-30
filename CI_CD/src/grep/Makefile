SHELL := /bin/bash
CC = gcc
CCFLAGS = -Wall -Wextra -Werror -std=c11

TARGET = s21_grep
GREP_SRC = s21_grep.c
GREP_FLAGS = -DGREP_FLAG

TEST_FILE = test_grep.txt
F_FILE = test_file.txt

all: clang s21_grep 

s21_grep: s21_grep.o
	$(CC) $(CCFLAGS) s21_grep.o -o $(TARGET)
	  

s21_grep.o: $(GREP_SRC)
	$(CC) $(CCFLAGS) $(GREP_SRC) -c 

clang:
	clang-format -style=Google -i s21_grep.c

clean:
	rm -f *.o
	rm -f s21_grep

test:
	#@TEST SET 0  (common tests)
	@echo "------------------TEST#0.0------------------"
	@-diff <(./s21_grep -e "qwe" -n test_grep1.txt test_grep2.txt) <(grep -e "qwe" -n test_grep1.txt test_grep2.txt) -s

	@echo "------------------TEST#0.1------------------"
	@-diff <(./s21_grep -e "qwe" -n test_grep1.txt test_grep2.txt) <(grep -e "qwe" -n test_grep1.txt test_grep2.txt) -s

	@echo "------------------TEST#0.2------------------"
	@-diff <(./s21_grep -n qwe test_grep1.txt test_grep2.txt) <(grep -n qwe test_grep1.txt test_grep2.txt) -s


    #@TEST SET 1  (-e support)

	@echo "------------------TEST#1.0------------------"
	@-diff <(./s21_grep -e "qwe" test_grep1.txt) <(grep -e "qwe" test_grep1.txt ) -s
	
	@echo "------------------TEST#1.1------------------"
	@-diff <(./s21_grep -e "qwe" test_grep1.txt test_grep2.txt) <(grep -e "qwe" test_grep1.txt test_grep2.txt) -s
	
	@echo "------------------TEST#1.2------------------"
	@-diff <(./s21_grep -e "popo" test_grep1.txt test_grep2.txt) <(grep -e "popo" test_grep1.txt test_grep2.txt) -s


	#@TEST SET 2  (-v support)
	@echo "------------------TEST#1.3_file-------------"
	@-diff <(./s21_grep QWE -i -v test_1_5.txt) <(grep QWE -i -v test_1_5.txt) -s
	
	@echo "------------------TEST#1.4------------------"
	@-diff <(./s21_grep -e 1q2 -vi test_data.txt) <(grep -e 1q2 -vi test_data.txt) -s

	@echo "------------------TEST#1.5------------------"
	@-diff <(./s21_grep -e 1q2 -v test_data.txt) <(grep -e 1q2 -v test_data.txt) -s


	#@TEST SET 2  (-c support)
	@echo "------------------TEST#1.6_file-------------"
	@-diff <(./s21_grep QWE -i -v -c test_1_5.txt) <(grep QWE -i -v -c test_1_5.txt) -s
	
	@echo "------------------TEST#1.7------------------"
	@-diff <(./s21_grep -e 1q2 -vi -c test_data.txt) <(grep -e 1q2 -vi -c test_data.txt) -s

	@echo "------------------TEST#1.8------------------"
	@-diff <(./s21_grep -e 1q2 -v -c test_data.txt) <(grep -e 1q2 -v -c test_data.txt) -s
	
	
	#@TEST SET 2  (-l support)
	@echo "------------------TEST#1.9-------------"
	@-diff <(./s21_grep -e 1q2 -v -l test_data.txt) <(grep -e 1q2 -v -l test_data.txt) -s

	@echo "------------------TEST#1.10-------------"
	@-diff <(./s21_grep -e qwe -v -l test_grep1.txt test_grep2.txt) <(grep -e qwe -v -l test_grep1.txt test_grep2.txt) -s

	#@TEST SET 2  (-n support)
	@echo "------------------TEST#1.13-------------"
	@-diff <(./s21_grep -e 1q2 -v -n test_data.txt) <(grep -e 1q2 -v -n test_data.txt) -s

	@echo "------------------TEST#1.14-------------"
	@-diff <(./s21_grep -e qwe -v -n test_grep1.txt test_grep2.txt) <(grep -e qwe -v -n test_grep1.txt test_grep2.txt) -s

	@echo "------------------TEST#1.15-------------"
	@-diff <(./s21_grep -e qwe -v -l -n test_grep1.txt test_grep2.txt) <(grep -e qwe -v -l -n test_grep1.txt test_grep2.txt) -s

    #@TEST SET 3!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
	@echo "------------------TEST#2.0-------------"
	@-diff <(./s21_grep -e prince $(TEST_FILE)) <(grep -e prince $(TEST_FILE)) -s
	@echo "------------------TEST#2.1-------------"
	@-diff <(./s21_grep -c prince $(TEST_FILE)) <(grep -c prince $(TEST_FILE)) -s
	@echo "------------------TEST#2.2-------------"
	@-diff <(./s21_grep -e prince $(TEST_FILE)) <(grep -e prince $(TEST_FILE)) -s
	@echo "------------------TEST#2.3-------------"
	@-diff <(./s21_grep -l prince $(TEST_FILE)) <(grep -l prince $(TEST_FILE)) -s
	@echo "------------------TEST#2.4-------------"
	@-diff <(./s21_grep -i prince $(TEST_FILE)) <(grep -i prince $(TEST_FILE)) -s
	@echo "------------------TEST#2.5-------------"
	@-diff <(./s21_grep -n prince $(TEST_FILE)) <(grep -n prince $(TEST_FILE)) -s


	#@TEST SET 4!!!!!!!!!!!!!!!!!!!!!!!!!!!!!  
	@echo "------------------TEST#2.0-------------"
	@-diff <(./s21_grep -e p $(TEST_FILE)) <(grep -e p $(TEST_FILE)) -s
	@echo "------------------TEST#2.1-------------"
	@-diff <(./s21_grep -c p $(TEST_FILE)) <(grep -c p $(TEST_FILE)) -s
	@echo "------------------TEST#2.2-------------"
	@-diff <(./s21_grep -e p $(TEST_FILE)) <(grep -e p $(TEST_FILE)) -s
	@echo "------------------TEST#2.3-------------"
	@-diff <(./s21_grep -l p $(TEST_FILE)) <(grep -l p $(TEST_FILE)) -s
	@echo "------------------TEST#2.4-------------"
	@-diff <(./s21_grep -i p $(TEST_FILE)) <(grep -i p $(TEST_FILE)) -s
	@echo "------------------TEST#2.5-------------"
	@-diff <(./s21_grep -n p $(TEST_FILE)) <(grep -n p $(TEST_FILE)) -s


	@echo "------------------TEST#3.0-------------"
	@diff <(grep -i "i" $(TEST_FILE)) <(./s21_grep -i "i" $(TEST_FILE)) -s 
	@diff <(grep -v "i" $(TEST_FILE)) <(./s21_grep -v "i" $(TEST_FILE)) -s 
	@diff <(grep -c "i" $(TEST_FILE)) <(./s21_grep -c "i" $(TEST_FILE)) -s 
	@diff <(grep -l "i" $(TEST_FILE)) <(./s21_grep -l "i" $(TEST_FILE)) -s 
	@diff <(grep -n "i" $(TEST_FILE)) <(./s21_grep -n "i" $(TEST_FILE)) -s 

	@echo "------------------TEST#3.0-------------"
	@diff <(grep -i "l;l;l;l;l;l;" $(TEST_FILE)) <(./s21_grep -i "l;l;l;l;l;l;" $(TEST_FILE)) -s
	@diff <(grep -v "kljkljk" $(TEST_FILE)) <(./s21_grep -v "kljkljk" $(TEST_FILE)) -s 
	@diff <(grep -c "jkl" $(TEST_FILE)) <(./s21_grep -c "jkl" $(TEST_FILE)) -s 
	@diff <(grep -l "ijkl" $(TEST_FILE)) <(./s21_grep -l "ijkl" $(TEST_FILE)) -s 
	@diff <(grep -n "jkljkl" $(TEST_FILE)) <(./s21_grep -n "jkljkl" $(TEST_FILE)) -s 

	@echo "------------------TEST#4.0-------------"
	@diff <(grep a -n -h test_data.txt test_file.txt) <(./s21_grep a -n -h test_data.txt test_file.txt) -s 
	@diff <(grep a -nhs test_data.txt nofile.txt) <(./s21_grep a -nhs test_data.txt nofile.txt) -s 
	@echo "------------------TEST#5.0-------------"
	@diff <(grep -f pattrn_file.txt -n test_data.txt) <(./s21_grep -f pattrn_file.txt -n test_data.txt) -s 
	@echo "------------------TEST#6.0-------------"
	@diff <(./s21_grep -o "bn" test_grep2.txt) <(grep -o "bn" test_grep2.txt) -s

