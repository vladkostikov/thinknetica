# Заполнить хеш гласными буквами, где значением будет являться
# порядковый номер буквы в алфавите (a - 1).

# Хэш, который нужно заполнить гласными буквами с порядковым номером в алфавите
vowels = {}

# Гласные буквы
letters = %w[A E I O U]

# Альфавит
alphabet = 'A'..'Z'

# Проходим по алфавиту и если буква гласная, то добавляем её в хэш,
# значение – это индекс в алфавите плюс 1
alphabet.each_with_index do |letter, index|
  vowels[letter] = index + 1 if letters.include?(letter)
end

print vowels
# => {"A"=>1, "E"=>5, "I"=>9, "O"=>15, "U"=>21}
