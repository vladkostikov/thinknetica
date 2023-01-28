# frozen_string_literal: true

# Код взят из 4 урока
# Задание:
# 1. Создать модуль, который позволит указывать название компании-производителя
# и получать его. Подключить модуль к классам Вагон и Поезд.
# 2. В классе RailwayStation создать метод класса all, который выводит
# список всех станций, созданных на данный момент.
require_relative './railway_station'
require_relative './route'
require_relative './passenger_train'
require_relative './cargo_train'
require_relative './passenger_carriage'
require_relative './cargo_carriage'

operations = {
  create_station: '1. Создать станцию',
  create_train: '2. Создать поезд',
  attach_carriage: '3. Прицепить вагон к поезду',
  detach_carriage: '4. Отцепить вагон от поезда',
  move_train: '5. Поместить поезд на станцию',
  show_stations: '6. Просмотреть список станций и список поездов на станции'
}

def create_station
  print 'Название станции: '
  name = gets.chomp

  station = RailwayStation.new(name)
  puts "Станция #{station.name} создана."
end

def create_train
  user_choice_number = 0
  until (1..2).include?(user_choice_number)
    puts 'Какой поезд хотите создать?',
         '1. Пассажирский',
         '2. Грузовой'
    user_choice_number = gets.to_i
  end

  train = PassengerTrain.new if user_choice_number == 1
  train = CargoTrain.new if user_choice_number == 2
  puts "Поезд #{train} создан."
end

def trains_info
  trains = Train.trains

  trains.each_with_index do |train, i|
    puts "#{i + 1}. #{train}"
  end
end

def attach_carriage
  trains = Train.trains

  user_choice_number = 0
  until (1..trains.size).include?(user_choice_number)
    puts 'К какому поезду хотите прицепить вагон?'
    trains_info
    user_choice_number = gets.to_i
  end

  train = trains[user_choice_number - 1]
  train.attach_carriage(PassengerCarriage.new) if train.instance_of?(PassengerTrain)
  train.attach_carriage(CargoCarriage.new) if train.instance_of?(CargoTrain)
end

def detach_carriage
  trains = Train.trains

  user_choice_number = 0
  until (1..trains.size).include?(user_choice_number)
    puts 'От какого поезда хотите отцепить вагон?'
    trains_info
    user_choice_number = gets.to_i
  end

  train = trains[user_choice_number - 1]
  train.detach_carriage
end

def move_train
  trains = Train.trains
  stations = RailwayStation.all

  user_choice_number = 0
  until (1..trains.size).include?(user_choice_number)
    puts 'Какой поезд хотите переместить?'
    trains_info

    user_choice_number = gets.to_i
  end
  train = trains[user_choice_number - 1]

  user_choice_number = 0
  until (1..stations.size).include?(user_choice_number)
    puts 'На какую станцию хотите переместить поезд?'
    stations.each_with_index do |station, i|
      puts "#{i + 1}. #{station.name}"
    end

    user_choice_number = gets.to_i
  end
  station = stations[user_choice_number - 1]

  station.receive_train(train)
  puts "Поезд #{train} перемещён на станцию #{station.name}."
end

def show_stations
  stations = RailwayStation.all

  stations.each_with_index do |station, station_index|
    puts "#{station_index + 1}. Станция #{station.name}"

    station.trains.each_with_index do |train, train_index|
      puts "\t#{train_index + 1}. #{train}"
    end
  end
end

PassengerTrain.new
RailwayStation.new('Москва')

loop do
  user_choice_number = 0
  until (1..operations.size).include?(user_choice_number)
    puts "\nЧто хотите сделать?(0 для выхода)"
    operations.each_value { |operation| puts operation }

    user_input = gets.chomp
    exit if user_input == '0'

    user_choice_number = user_input.to_i
  end

  user_choice_operation = operations.to_a[user_choice_number - 1][0]

  method(user_choice_operation).call
end
