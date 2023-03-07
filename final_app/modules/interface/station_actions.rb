# frozen_string_literal: true

require_relative '../../railway_station'

# Действия со станциями
module StationActions
  def create_station
    name = ask_name
    station = RailwayStation.new(name)
    puts "Станция #{station.name} создана."
  rescue StandardError
    puts 'Название станции должно состоять как минимум из 2 символов'
    retry
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

  def ask_name
    print 'Название станции: '
    gets.strip
  end

  def rename_station
    puts 'Какую станцию переименовать?'
    station = ask_station
    old_name = station.name

    begin
      name = ask_name
      raise NameError if RailwayStation.find(name) && station.name != name

      station.rename(name)
    rescue NameError
      puts 'Станция с таким названием уже существует'
      retry
    rescue StandardError
      puts 'Название станции должно состоять как минимум из 2 символов'
      retry
    end

    puts "Станция #{old_name} успешно переименована в #{station.name}"
  end
end
