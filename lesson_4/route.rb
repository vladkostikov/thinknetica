# frozen_string_literal: true

# Маршрут:
# Имеет начальную и конечную станцию, а также список промежуточных станций
# Маршрут может:
# 1. Добавлять станцию в список
# 2. Удалять станцию из списка
# 3. Выводить список всех станций по-порядку от начальной до конечной
class Route
  attr_reader :list

  def initialize
    @list = []
  end

  def add_station(station)
    @list << station
  end

  def delete_station(station)
    list.delete(station)
  end

  def first_station
    @first_station = list.first
  end

  def last_station
    @last_station = list.last
  end
end
