# Прямоугольный треугольник
# Программа запрашивает у пользователя 3 стороны треугольника и определяет,
# является ли треугольник прямоугольным, используя теорему Пифагора
# и выводит результат на экран.
#
# Также, если треугольник является при этом равнобедренным
# (т.е. у него равны любые 2 стороны), то дополнитьельно выводится информация
# о том, что треугольник еще и равнобедренный.
#
# Подсказка: чтобы воспользоваться теоремой Пифагора, нужно сначала найти
# самую длинную сторону (гипотенуза) и сравнить ее значение в квадрате
# с суммой квадратов двух остальных сторон.
# Если все 3 стороны равны, то треугольник равнобедренный и равносторонний,
# но не прямоугольный.

print 'Введите длину первой стороны треугольника: '
first_side = gets.to_f

print 'Введите длину второй стороны треугольника: '
second_side = gets.to_f

print 'Введите длину третьей стороны треугольника: '
third_side = gets.to_f

# Создаем массив со сторонами и сортируем
# Запоминаем максимальную длину стороны(гипотенузу)
sides = [first_side, second_side, third_side].sort
hypotenuse = sides.max

# Выводим ошибку если введена хотя бы одна неположительная сторона
sides.each do |side|
  if side <= 0
    puts 'Ошибка. Все длины сторон треугольника должны быть положительными.'
    exit
  end
end

# Выводим ошибку если треугольника с такими сторонами не может существовать
if sides[0] + sides[1] <= sides[2] ||
   sides[1] + sides[2] <= sides[0] ||
   sides[2] + sides[0] <= sides[1]
  puts 'Ошибка. Треугольника с такими длинами сторон не может существовать.'
  puts 'Правило => Сумма любых двух сторон, должна быть больше третьей стороны.'
  exit
end

# Проверяем является ли треугольник прямоугольным
is_right_triangle = sides[0]**2 + sides[1]**2 == hypotenuse**2

# Проверяем является ли треугольник равнобедренным
is_isosceles_triangle = sides[0] == sides[1] || sides[1] == hypotenuse

# Проверяем является ли треугольник равносторонним
is_equilateral_triangle = sides[0] == sides[1] && sides[1] == sides[2]

# Подготавливаем строку для вывода результата
array_for_result = []
array_for_result << 'Прямоугольный' if is_right_triangle
array_for_result << 'Непрямоугольный' if !is_right_triangle
array_for_result << 'Равнобедренный' if is_isosceles_triangle
array_for_result << 'Равносторонний' if is_equilateral_triangle
array_for_result << 'Разносторонний' if !is_isosceles_triangle && !is_equilateral_triangle
result = array_for_result.join(', ').capitalize

# Выводим результат
puts "Треугольник со сторонами: #{first_side}, #{second_side}, #{third_side}"
puts result