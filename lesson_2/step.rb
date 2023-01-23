# Заполнить массив числами от 10 до 100 с шагом 5.

arr = []
range = 10..100

range.step(5) do |number|
  arr << number
end
