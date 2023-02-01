# frozen_string_literal: true

require_relative '../../train/passenger_train'
require_relative '../../train/cargo_train'

module TrainActions
  def types_of_trains
    {
      PassengerTrain => 'Пассажирский',
      CargoTrain => 'Грузовой'
    }
  end

  def create_train
    type_of_train = ask_type_of_train

    begin
      number = ask_number_of_train
      train = type_of_train.new(number)
    rescue StandardError => e
      puts "#{e}\n"
      retry
    end

    puts "Поезд #{train} создан."
  end

  # Возвращает Class выбранного поезда
  def ask_type_of_train
    user_choice_number = nil
    until (1..types_of_trains.size).include?(user_choice_number)
      puts 'Какой поезд хотите создать?'
      print_types_of_trains
      user_choice_number = gets.to_i
    end
    index_of_type = user_choice_number - 1

    types_of_trains.to_a[index_of_type][0]
  end

  def print_types_of_trains
    types_of_trains.each_with_index do |(_type, type_in_russian), index|
      puts "#{index + 1}. #{type_in_russian}"
    end
  end

  def ask_number_of_train
    puts 'У поезда должен быть номер'
    puts 'Формат номера: 5 букв или цифр в любом порядке, после 3 символа '\
       'может быть дефис(необязательно)'
    print 'Введите номер поезда: '
    gets.chomp
  end

  def print_trains
    raise 'Нет поездов' if trains.empty?

    trains.each_with_index do |train, i|
      puts "#{i + 1}. #{train}"
    end
  end

  # Возвращает поезд
  def ask_train
    user_choice_number = nil
    until (1..trains.size).include?(user_choice_number)
      print_trains
      user_choice_number = gets.to_i
    end
    trains[user_choice_number - 1]
  end

  def move_train
    puts 'Какой поезд хотите переместить?'
    train = ask_train
    puts 'На какую станцию хотите переместить поезд?'
    station = ask_station

    station.receive_train(train)
    puts "Поезд #{train} перемещён на станцию #{station.name}."
  end

  def trains
    CargoTrain.all + PassengerTrain.all
  end
end
