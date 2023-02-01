# frozen_string_literal: true

require_relative '../../railway_station'

module StationActions
  def create_station
    print 'Название станции: '
    name = gets.chomp

    station = RailwayStation.new(name)
    puts "Станция #{station.name} создана."
  end

  def stations
    RailwayStation.all
  end

  def print_stations
    raise 'Нет станций' if stations.empty?

    stations.each_with_index do |station, i|
      puts "#{i + 1}. #{station.name}"
    end
  end

  # Возвращает выбранную станцию
  def ask_station
    user_choice_number = nil
    until (1..stations.size).include?(user_choice_number)
      print_stations
      user_choice_number = gets.to_i
    end

    stations[user_choice_number - 1]
  end

  def print_stations_with_trains
    raise 'Нет станций' if stations.empty?

    stations.each_with_index do |station, station_index|
      puts "#{station_index + 1}. #{station.info}"
      station.print_trains_info
    end
  end
end
