# Заполнить массив числами Фибоначчи до 100.
# Последнее добавленное число должно быть меньше 100.

fibbonacci = [0]

next_number = 1

while next_number < 100
  fibbonacci << next_number
  next_number = fibbonacci[-1] + fibbonacci[-2]
end
