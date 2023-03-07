# frozen_string_literal: true

# Маршрут
class Route
  attr_reader :stations

  def initialize
    @stations = []
  end

  def add_station(station)
    raise impossible_add_station unless station.is_a?(RailwayStation)

    @stations << station
  end

  def delete_station(station)
    stations.delete(station)
  end

  def first_station
    @first_station = stations.first
  end

  def last_station
    @last_station = stations.last
  end

  private

  def impossible_add_station
    'Невозможно добавить это в маршрут, потому что это не железнодорожная станция.'
  end
end
