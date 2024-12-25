#!/bin/bash

# !!! Знак $ нужно экранировать с помощью обратной косой черты
# !!! НУЖНЫ пробелы ПОСЛЕ и ДО квадратных скобок при проверке условий
# !!! Пробелы ДО и ПОСЛЕ знака равно при объявлении переменных НЕ СТАВЯТСЯ
# !!! Операторы > и < нужно экранировать с помощью обратной косой черты при проверке условия

# Получение количества переменных в системе
###
getconf ARG_MAX

# Вывод сообщений
###
echo "Текущая директория:"
pwd
echo "Пользователь залогинился под:"
whoami

# Аеременные среды
###
echo "My HOME is: $HOME"

echo "I have \$1"

# Пользовательские переменные
###
grade=5
person="Adam"
echo "$person имееет $grade яблок"

# Подстановка команд
###
mydir=`pwd`
mydir1=$(pwd)
echo $mydir
echo $mydir1

# Математические операции
###
var1=$((7+14))
echo $var1
var2=$(($var1*3)) # Используется "$()" а внутри !В СКОБКАХ математическое выражение
echo $var2

# Условие if-then
###
user="ddd"
if grep $user /etc/passwd > /dev/null  # Прячем вывод ошибок и успешного выполнения
then
   echo "Пользователь $user существует"
fi

# Условие if-then-else
###
user="какой-то_пользователь"
if grep $user /etc/passwd > /dev/null  # Прячем вывод ошибок и успешного выполнения
then
   echo "Пользователь $user существует"
   else
      echo "Пользователя $user не существует"
fi

# Проверка нескольких условий
###
user1="какой-то_пользователь"
if grep $user1 /etc/passwd > /dev/null  # Прячем вывод ошибок и успешного выполнения
then
   echo "Пользователь $user1 существует"
   elif ls /home
   then
      echo "Пользователь не найден нигде в директории /home"
fi

# Сравнение чисел !!! Используются ПРИ СРАВНЕНИИ ЧИСЕЛ
# n1 -eq n2 Возвращает истинное значение, если n1 равно n2
# n1 -ge n2 Возвращает истинное значение, если n1 больше или равно n2
# n1 -gt n2 Возвращает истинное значение, если n1 больше n2
# n1 -le n2 Возвращает истинное значение, если n1 меньше или равно n2
# n1 -lt n2 Возвращает истинное значение, если n1 меньше n2
# n1 -ne n2 Возвращает истинное значение, если n1 не равно n2
###
per=6
if [ $per -gt 5 ] # ! Нужны пробелы ПОСЛЕ и ДО квадратных скобок ! Перед "gt" должен быть "-"
then
   echo "Число $per больше 5"
else
   echo "Число $per не больше 5"
fi

# Сравнение строк !!! Используются ПРИ СРАВНЕНИИ СТРОК
# str1 = str2 Проверяет строки на равенство, возвращает истину, если строки идентичны
# str1 != str2 Возвращает истину, если строки не идентичны
# str1 < str2 Возвращает истину, если str1 меньше, чем str2
# str1 > str2 Возвращает истину, если str1 больше, чем str2
# -n str1 Возвращает истину, если длина str1 больше нуля
# -z str1 Возвращает истину, если длина str1 равна нулю
###
user2="root"
if [ $user2=$USER ] # ! В сравнении используются квадратные скобки ! Нужны пробелы ПОСЛЕ и ДО квадратных скобок
then
   echo "Сейчас залогинен пользователь $user2"
fi

###
per1=text
per2="another text" # ! Заключили в кавычки, потому что есть пробел в переменной
if [ $per1 \> "$per2" ] # ! Операторы > и < нужно экранировать с помощью обратной косой черты при проверке условия.
# ! Переменная, объявленная в кавычках, учавствует в сравнении тоже в кавычках
then
   echo "$per1 больше, чем $per2"
else
   echo "$per1 меньше, чем $per2"
fi

###
val1=Likegeeks
val2=likegeeks
if [ $val1 \> $val2 ] # ! Операторы > и < нужно экранировать с помощью обратной косой черты при проверке условия.
then
   echo "$val1 больше, чем $val2"
else
   echo "$val1 меньше, чем $val2"
fi

# Проверки файлов
# -d file Проверяет, существует ли файл, и является ли он директорией
# -e file Проверяет, существует ли файл
# -f file Проверяет, существует ли файл, и является ли он файлом
# -r file Проверяет, существует ли файл, и доступен ли он для чтения
# -s file Проверяет, существует ли файл, и не является ли он пустым
# -w file Проверяет, существует ли файл, и доступен ли он для записи
# -x file Проверяет, существует ли файл, и является ли он исполняемым
# file1 -nt file2 Проверяет, новее ли file1, чем file2
# file1 -ot file2 Проверяет, старше ли file1, чем file2
# -O file Проверяет, существует ли файл, и является ли его владельцем текущий пользователь
# -G file Проверяет, существует ли файл, и соответствует ли его идентификатор группы идентификатору группы текущего пользователя
###
mydir=/home/ddd
if [ -d $mydir ] # ! В сравнении используются квадратные скобки ! Нужны пробелы ПОСЛЕ и ДО квадратных скобок
then
   echo "Директория $mydir существует"
   cd $mydir
   ls
else
   echo "Директории $mydir не существует"
fi