# frozen_string_literal: true

require_relative '../route'
require_relative 'interface/station_actions'
require_relative 'interface/train_actions'
require_relative 'interface/carriage_actions'

# Текстовый интерфейс программы
module Interface
  include StationActions
  include TrainActions
  include CarriageActions

  def operations
    {
      create_station: 'Создать станцию',
      create_train: 'Создать поезд',
      attach_carriage: 'Прицепить вагон',
      detach_carriage: 'Отцепить вагон',
      move_train: 'Отправить поезд',
      change_train_number: 'Изменить номер поезда',
      rename_station: 'Переименовать станцию',
      print_trains: 'Показать список поездов',
      print_stations_with_trains: 'Показать список станций и список поездов на станциях'
    }
  end

  # Возвращает выбор пользователя
  def ask_menu_operation
    user_choice_number = nil
    until (1..operations.size).include?(user_choice_number)
      puts "\nЧто сделать?(0 для выхода)"
      print_menu
      user_input = gets.strip
      exit if user_input == '0'

      user_choice_number = user_input.to_i
    end
    operations.keys[user_choice_number - 1]
  end

  def print_menu
    operations.each_with_index do |(_action, description), index|
      puts "#{index + 1}. #{description}"
    end
  end

  def app
    method(ask_menu_operation).call
  rescue StandardError => e
    puts e
  end

  def start
    loop do
      app
    end
  end
end
