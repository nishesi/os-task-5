#!/bin/bash

total_attempts=0
correct_attempts=0
incorrect_attempts=0
last_numbers=""
step_color=""

while true; do

  ((total_attempts++))
  echo "Шаг: $total_attempts"

  secret_number=$((RANDOM % 10))

  read -p "Введите число от 0 до 9 (q для выхода): " user_input

  if [ "$user_input" == "q" ]; then
    show_statistics
    echo "Игра завершена. До свидания!"
    exit 0
  fi

  if [[ ! "$user_input" =~ ^[0-9]$ ]]; then
    echo "Ошибка: Введите число от 0 до 9 или q для выхода."
    continue
  fi

  if [ "$user_input" -eq "$secret_number" ]; then
    step_color="\e[32m"
    ((correct_attempts++))
    echo -e "\e[32mПоздравляем! Вы угадали число\e[0m"
  else
    step_color="\e[91m"
    ((incorrect_attempts++))
    echo -e "\e[91mУвы! Не угадали. Загаданное число: $secret_number\e[0m"
  fi
  let percent=correct_attempts*100/total_attempts
  echo "Угадано: $correct_attempts (${percent}%)"
  let percent2=incorrect_attempts*100/total_attempts
  echo "Не угадано: $incorrect_attempts (${percent2}%)"

  last_numbers="$step_color$user_input\e[0m $last_numbers"
  last_numbers=$(echo $last_numbers | cut -d' ' -f1-10)
  echo -e "Последние 10 чисел: $last_numbers"
done
