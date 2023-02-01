# frozen_string_literal: true

require_relative 'station_actions'
require_relative 'train_actions'
require_relative 'carriage_actions'
require_relative '../../route'

# Текстовый интерфейс программы
module Interface
  include StationActions
  include TrainActions
  include CarriageActions

  def operations
    {
      create_station: '1. Создать станцию',
      create_train: '2. Создать поезд',
      attach_carriage: '3. Прицепить вагон к поезду',
      detach_carriage: '4. Отцепить вагон от поезда',
      move_train: '5. Поместить поезд на станцию',
      print_stations_with_trains: '6. Посмотреть список станций и список поездов на станции'
    }
  end

  def print_menu
    operations.each_value { |operation| puts operation }
  end

  # Возвращает выбор пользователя
  def ask_menu_operation
    user_choice_number = nil
    until (1..operations.size).include?(user_choice_number)
      puts "\nЧто хотите сделать?(0 для выхода)"
      print_menu
      user_input = gets.chomp
      exit if user_input == '0'

      user_choice_number = user_input.to_i
    end
    operations.to_a[user_choice_number - 1][0]
  end

  def app
    method(ask_menu_operation).call
  rescue StandardError => e
    puts e
  end

  def run_interface
    loop do
      app
    end
  end
end
