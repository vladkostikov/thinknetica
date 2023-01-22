# Площадь треугольника
# Площадь треугольника можно вычислить, зная его основание (a) и высоту (h) по формуле: 1/2*a*h
# Программа должна запрашивать основание и высоту треуголиника и возвращать его площадь

print 'Введите основание треугольника: '
base = gets.to_f

if base <= 0
  puts 'Ошибка. Основание должно быть положительным.'
  exit
end

print 'Введите высоту треугольника: '
height = gets.to_f

if base <= 0
  puts 'Ошибка. Высота должна быть положительной.'
  exit
end

area = height * base / 2

puts "Площадь треугольника: #{area}"
