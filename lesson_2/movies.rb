# Программа для учёта просмотренных фильмов

movies = {
  'Зеленая миля': 9.2,
  'Интерстеллар': 8.8,
  'Вышка': 6.7,
  'Гладиатор': 8.7,
  'Голодные игры': 8.7
}

puts 'Что вы хотите сделать?'
puts '1. Добавить новый фильм'
puts '2. Изменить рейтинг'
puts '3. Удалить фильм'
puts '4. Показать все фильмы'
print 'Выберите номер действия: '

# Сохраняем выбор пользователя. Выводим ошибку если указан неправильный номер.
choice = gets.to_i
unless (1..4).include?(choice)
  puts "Ошибка. Я не знаю действие №#{choice}. Пожалуйста введите число от 1 до 4."
  exit
end

# Преобразуем номер действия в символ
choice = [:create, :update, :delete, :read][choice-1]

case choice
# 1. Добавить новый фильм
when :create
  puts 'Добавляем новый фильм'
  print 'Название: '
  title = gets.chomp.to_sym

  # Сохраняем, если фильм ещё не был добавлен
  if movies[title].nil?
    # Запрашиваем рейтинг, сохраняем только 1 цифру после запятой
    print 'Рейтинг: '
    rating = gets.to_f.floor(1)

    # Сохраняем
    movies[title] = rating
    puts "Сохранено успешно. #{title}: #{movies[title]}"
  # Выводим ошибку если фильм уже существует
  else
    puts "Ошибка. Фильм #{title} уже существует."
    puts "#{title}: #{movies[title]}"
  end

# 2. Изменить рейтинг
when :update
  puts 'Изменяем рейтинг'
  print 'Название: '
  title = gets.chomp.to_sym

  # Изменяем рейтинг, либо выводим ошибку если фильм не найден
  if movies[title].nil?
    puts "Ошибка. Фильм #{title} не найден."
  else
    # Запрашиваем рейтинг, сохраняем только 1 цифру после запятой
    print 'Новый рейтинг: '
    rating = gets.to_f.floor(1)

    # Сохраняем и выводим новый рейтинг
    movies[title] = rating
    puts "Рейтинг обновлён. #{title}: #{movies[title]}"
  end

# 3. Удалить фильм
when :delete
  puts 'Удаляем фильм'
  print 'Название: '
  title = gets.chomp.to_sym

  # Удаляем фильм, либо выводим ошибку если фильм не найден
  if movies[title]
    movies.delete(title)
    puts "Фильм #{title} успешно удалён."
  else
    puts "Ошибка. Фильм #{title} не найден."
  end

# 4. Показать все фильмы
when :read
  puts 'Список фильмов:'
  movies.each do |movie, rating|
    puts "#{movie}: #{rating}"
  end
end
