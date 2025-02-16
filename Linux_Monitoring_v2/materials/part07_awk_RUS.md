# Bash-скрипты, часть 7: язык обработки данных awk

Утилита awk, или точнее GNU awk, в сравнении с sed, выводит обработку потоков данных на более высокий уровень. Благодаря awk в нашем распоряжении оказывается язык программирования, а не довольно скромный набор команд, отдаваемых редактору. С помощью языка программирования awk можно выполнять следующие действия:
- Объявлять переменные для хранения данных.
- Использовать арифметические и строковые операторы для работы с данными.
- Использовать структурные элементы и управляющие конструкции языка, такие, как оператор if-then и циклы, что позволяет реализовать сложные алгоритмы обработки данных.
- Создавать форматированные отчёты.

Утилита awk предоставляет очень много возможностей, так как в ней есть многие конструкции, присущие полноценным языкам программирования, например, условные операторы, циклы, пользовательские переменные и функции и т. д. Однако здесь будет описан лишь краткий пример, показывающий суть работы с этой утилитой.

Если говорить лишь о возможности создавать форматированные отчёты, которые удобно читать и анализировать, то это оказывается очень кстати при работе с лог-файлами.

Схема вызова awk выглядит так:
```shell
awk options program file
```

Awk воспринимает поступающие к нему данные в виде набора записей. Записи представляют собой наборы полей. Упрощенно, если не учитывать возможности настройки awk и говорить о некоем вполне обычном тексте, строки которого разделены символами перевода строки, запись — это строка. Поле — это слово в строке.

### Позиционные переменные

Работа с переменными в awk похожа на работу с параметрами командной строки в bash. По умолчанию awk назначает следующие переменные каждому полю данных, обнаруженному им в записи:
- $0 — представляет всю строку текста (запись).
- $1 — первое поле.
- $2 — второе поле.
- $n — n-ное поле.

Поля выделяются из текста с использованием символа-разделителя. По умолчанию это пробельные символы вроде пробела или символа табуляции.

### Использование нескольких команд

Awk позволяет обрабатывать данные с использованием многострочных скриптов. Для того, чтобы передать awk многострочную команду при вызове его из консоли, нужно разделить её части точкой с запятой:
```shell
echo "My name is Tom" |
awk '{
$4="Adam";
print $0
}'
```

В данном примере первая команда записывает новое значение в переменную $4, а вторая выводит на экран всю строку. Результат работы скрипта:
```shell
My name is Adam
```

### Форматированный вывод данных

Команда printf в awk позволяет выводить форматированные данные с помощью спецификаторов форматирования.

Спецификаторы форматирования записывают в таком виде:
```shell
%[modifier]control-letter
```

Вот некоторые из них:
- c — воспринимает переданное ему число как код ASCII-символа и выводит этот символ.
- d — выводит десятичное целое число.
- i — то же самое, что и d.
- e — выводит число в экспоненциальной форме.
- f — выводит число с плавающей запятой.
- g — выводит число либо в экспоненциальной записи, либо в формате с плавающей запятой, в зависимости от того, как получается короче.
- o — выводит восьмеричное представление числа.
- s — выводит текстовую строку.

Вот пример форматирования выводимых данных с помощью printf:
```shell
awk 'BEGIN{
x = 100 * 100
printf "The result is: %e\n", x
}'
```

