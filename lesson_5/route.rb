# frozen_string_literal: true

# Маршрут
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
