# Заполнить массив числами Фибоначчи до 100.

fibbonacci = [0, 1]

while fibbonacci.size < 100 do
  fibbonacci << fibbonacci[-1] + fibbonacci[-2]
end
