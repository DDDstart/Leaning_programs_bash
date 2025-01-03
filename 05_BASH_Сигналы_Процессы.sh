#!/bin/bash
# Сигналы Linux
# Код сигнала   Название       Описание
# 1             SIGHUP         Закрытие терминала
# 2             SIGINT         Сигнал остановки процесса пользователем с терминала (CTRL + C)
# 3             SIGQUIT        Сигнал остановки процесса пользователем с терминала (CTRL + \) с дампом памяти
# 9             SIGKILL        Безусловное завершение процесса
# 15            SIGTERM        Сигнал запроса завершения процесса
# 17            SIGSTOP        Принудительная приостановка выполнения процесса, но не завершение его работы
# 18            SIGTSTP        Приостановка процесса с терминала (CTRL + Z), но не завершение работы
# 19            SIGCONT        Продолжение выполнения ранее остановленного процесса

# Перехват сигналов. Для отслеживания сигналов Linux, используется команда TRAP
##
trap "echo \"Перехват CTRL-C\" " SIGINT # ! Вложеная команда TRAP (ловушка) и ECHO, экранирование двойных кавычек, без экранирование можно использовать одинарные кавычки
count=1
while [ $count -le 10 ] # Пока <= 10
do
   echo "Цикл $count"
   sleep 1
   count=$(($count+1))
done

# Перехват сигнала выхода из скрипта
# Перехватить сигнал выхода из скрипта можно, использовав при вызове команды TRAP имя сигнала EXIT
##
trap "echo До свидания " EXIT
count=1
while [ $count -le 5 ]
do
   echo "Цикл $count"
   sleep 1
   count=$(($count+1))
done

# Модификация перехваченных сигналов и отмена перехвата
# Для модификации перехваченных скриптом сигналов можно выполнить команду trap с новыми параметрами
##
trap "echo 'CTRL-C перехвачен!'" SIGINT # ! Вложеная команда TRAP и ECHO
count=1
while [ $count -le 5 ]
do
   echo "Цикл $count"
   sleep 1
   count=$(($count+1))
done
trap "echo Я модифицирую перехват" SIGINT
count=1
while [ $count -le 5 ]
do
   echo "ВТОРОЙ цикл $count"
   sleep 1
   count=$(($count+1))
done

# Отмена перехвата сигналов
# Перехват сигналов можно и отменить, для этого достаточно выполнить команду TRAP, передав ей двойное тире и имя сигнала
##
trap "echo 'CTRL-C перехвачен!'" SIGINT
count=1
while [ $count -le 5 ]
do
   echo "Цикл $count"
   sleep 1
   count=$(($count+1))
done
trap -- SIGINT
echo "Я только что удалил перехват"
count=1
while [ $count -le 5 ]
do
   echo "Цикл $count"
   sleep 1
   count=$(($count+1))
done
# Первое нажатие CTRL + C пришлось на момент исполнения скрипта, когда перехват сигнала был в силе, поэтому скрипт исполнил назначенную сигналу команду echo
# После того, как исполнение дошло до команды отмены перехвата, команда CTRL + C сработала обычным образом, завершив работу скрипта

# Выполнение сценариев командной строки в фоновом режиме (нужно запустить скрипт с символом амперсанда "&" в конце
# Иногда bash-скриптам требуется немало времени для выполнения некоей задачи
# При этом вам может понадобиться возможность нормально работать в командной строке, не дожидаясь завершения скрипта
##
count=1
while [ $count -le 10 ]
do
   sleep 1
   count=$(($count+1))
done
# Запустим скрипт, указав после имени символ амперсанда (&): ./myscipt &
# При таком подходе, если выйти из терминала, скрипт, выполняющийся в фоне, так же завершит работу

# Выполнение скриптов, не завершающих работу при закрытии терминала: нужно запустить скрипт так "nohup ./myscript &"
# Скрипты можно выполнять в фоновых процессах даже после выхода из терминальной сессии
# Для этого можно воспользоваться командой nohup. Эта команда позволяет запустить программу, блокируя сигналы SIGHUP, отправляемые процессу
# В результате процесс будет исполняться даже при выходе из терминала, в котором он был запущен
##
count=1
while [ $count -le 30 ]
do
   echo "Этот вывод будет с nohup.out"
   sleep 1
   count=$(($count+1))
done
# Запустим скрипт, указав "nohup ./myscript &"
# Команда NOHUP отвязывает процесс от терминала. Это означает, что процесс потеряет ссылки на STDOUT и STDERR
# Для того, чтобы не потерять данные, выводимые скриптом, nohup автоматически перенаправляет сообщения, поступающие в STDOUT и в STDERR, в файл nohup.out

# Просмотр заданий. Команда JOBS позволяет просматривать текущие задания, которые выполняются в оболочке
##
count=1
while [ $count -le 10 ]
do
   echo "Этот цикл № $count"
   sleep 10
   count=$(($count+1))
done
# Запустим скрипт: ./myscript > outfile &
# ВыполниМ команду "jobs" или "jobs -l", увидим сведения как о приостановленном скрипте, так и о том, который работает в фоне

# Перезапуск приостановленных заданий
##
count=1
while [ $count -le 10 ]
do
   echo "Этот цикл № $count"
   sleep 10
   count=$(($count+1))
done
# Запустим скрипт: ./myscript и временно остановим комбинацией клавиш CTRL + Z
# Запустим тот же скрипт в фоновом режиме, при этом перенаправим вывод скрипта в файл так, чтобы он ничего не выводил на экране: ./myscript > outfile &
# Выполнив теперь команду "jobs" или "jobs -l", мы увидим сведения как о приостановленном скрипте, так и о том, который работает в фоне
# Для того, чтобы перезапустить скрипт в фоновом режиме, можно воспользоваться командой "bg" и указать порядковый номер
# Для перезапуска задания в обычном режиме воспользуйтесь командой fg с указанием номера задания из команды "jobs -l"

# Планирование запуска скриптов. Команда AT
# Вызов команды at выглядит так: "at [-f filename] <время>"
# Эта команда распознаёт множество форматов указания времени
# Стандартный, с указанием часов и минут, например — 10:15.
# С использованием индикаторов AM/PM, до или после полудня, например — 10:15PM.
# С использованием специальных имён, таких, как now, noon, midnight.
# Стандартный формат указания даты, при котором дата записывается по шаблонам MMDDYY, MM/DD/YY, или DD.MM.YY.
# Текстовое представление даты, например, Jul 4 или Dec 25, при этом год можно указать, а можно обойтись и без него.
# Запись вида now + 25 minutes.
# Запись вида 10:15PM tomorrow.
# Запись вида 10:15 + 7 days
##
# count=1
while [ $count -le 10 ]
do
   echo "Этот цикл № $count"
   sleep 10
   count=$(($count+1))
done
# Запустим скрипт: at -f ./myscript now
# Для того чтобы посмотреть список заданий, ожидающих выполнения, можно воспользоваться командой "atq"
# Удалить задание, ожидающее выполнения, позволяет команда "atrm <Номер_задания>". Номер задания берется из команды "atq"

# Запуск скриптов по расписанию. Смотри использование "crontab"
# Пример: 30 10 * * * /home/likegeeks/Desktop/myscript
# Формат: минута, час, день месяца, месяц, день недели
# Организовать периодический запуск скриптов с использованием cron можно ещё проще, воспользовавшись несколькими специальными директориями:
# /etc/cron.hourly
# /etc/cron.daily
# /etc/cron.weekly
# /etc/cron.monthly
# Если поместить файл скрипта в одну из них, это приведёт, соответственно, к его ежечасному, ежедневному, еженедельному или ежемесячному запуску.

# Запуск скриптов при входе в систему и при запуске оболочки
# Автоматизировать запуск скриптов можно, опираясь на различные события, такие, как вход пользователя в систему или запуск оболочки.
# Разместить скрипты можно в следующих файлах:
# $HOME/.bash_profile
# $HOME/.bash_login
# $HOME/.profile
# Для того, чтобы запускать скрипт при входе в систему, поместите его вызов в файл .bash_profile
# Чтобы запустить скрипт при открытии терминала, нужно добавить его в файл .bashrc
