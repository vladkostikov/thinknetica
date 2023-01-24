# Корзина покупок
#
# Пользователь вводит поочередно название товара, цену за единицу
# и количество купленного товара(может быть нецелым числом).
#
# Пользователь может ввести произвольное количество товаров до тех пор,
# пока не введет "стоп" в качестве названия товара.
#
# На основе введенных данных требуетеся:
# 1. Заполнить и вывести на экран хеш, ключами которого являются названия товаров,
#    а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара.
#    Также вывести итоговую сумму за каждый товар.
#
# 2. Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".

cart = {}

puts 'Программа для подсчёта суммы покупок'
puts 'Введите название, цену за единицу и количество купленного товара'
# Выводим текст зелёным цветом
puts "\e[32mВведите СТОП в названии, чтобы остановиться и показать корзину и итоговую сумму\e[0m"

# В цикле спрашиваем название, цену и количество, пока не будет введено СТОП
loop do
  print "\nНазвание: "
  title = gets.chomp
  break if title.upcase == 'СТОП'

  print 'Цена за единицу: '
  price = gets.to_f

  print 'Количество купленного товара: '
  amount = gets.to_f

  cart[title.to_sym] = { price: price, amount: amount }
end

# Заголовок корзины
puts "\n# Название\tЦена\tКоличество\tИтого"

# Итоговая сумма всех покупок
total_price_cart = 0

# Выводим построчно каждую покупку и подсчитываем итоговую сумму
cart.each_with_index do |(title, product), i|
  price = product[:price]
  amount = product[:amount]
  total_price = price * amount
  total_price_cart += total_price

  puts "#{i + 1} #{title} | #{price} ₽ | #{amount} шт. | #{total_price} ₽"
end

puts "\nИтоговая сумма всех покупок: #{total_price_cart} ₽"