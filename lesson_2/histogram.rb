# Программа для построения гистограммы текста.
# Выводит частоту слов в тексте в порядке убывания.

puts 'Пожалуйста введите текст для построения гистограммы:'
text = gets.chomp

# Делим текст на слова
words = text.split

# Создаём хэш с дефолтным значением 0
frequencies = Hash.new(0)

# Добавляем слова в хэш и увеличиваем значение на 1
words.each do |word|
  frequencies[word] += 1
end

# Сортируем по убыванию
frequencies = frequencies.sort_by { |k, v| -v }

# Выводим результат
frequencies.each do |k, v|
  puts "#{k} – #{v}"
end
