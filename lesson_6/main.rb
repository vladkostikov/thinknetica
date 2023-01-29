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

require_relative 'railway_station'
require_relative 'route'
require_relative 'train/passenger_train'
require_relative 'train/cargo_train'
require_relative 'carriage/passenger_carriage'
require_relative 'carriage/cargo_carriage'

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

  puts 'У поезда должен быть номер'
  puts 'Формат номера: 3 буквы или цифры, необязательный дефис, 2 буквы или цифры'
  print 'Введите номер поезда: '
  number = gets.chomp

  train = PassengerTrain.new(number) if user_choice_number == 1
  train = CargoTrain.new(number) if user_choice_number == 2
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

PassengerTrain.new('АМР-77')
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
rescue StandardError => e
  puts e
end
