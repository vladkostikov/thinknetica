# frozen_string_literal: true

# Код взят из 5 урока
# 1. Реализовать проверку (валидацию) данных для всех классов.
# Проверять основные атрибуты(название, номер, тип и т.п.) на наличие,
# длину и т.п.(в зависимости от атрибута):
# 1.1 Валидация должна вызываться при создании объекта,
# если объект невалидный, то должно выбрасываться исключение.
# 1.2 Должен быть метод valid? который возвращает true, если объект валидный
# и false - если объект невалидный.
# 2. Релизовать проверку на формат номера поезда.
# Допустимый формат: три буквы или цифры в любом порядке, необязательный дефис
# и еще 2 буквы или цифры после дефиса.
# 3. Реализовать интерфейс, который бы выводил пользователю
# ошибки валидации без прекращения работы программы.
# 4. Убрать из классов все puts, кроме методов, которые и должны что-то
# выводить на экран. Методы должны просто возвращать значения.
# Начинаем бороться за чистоту кода.

require_relative 'modules/interface'

include Interface

loop do
  app
end
