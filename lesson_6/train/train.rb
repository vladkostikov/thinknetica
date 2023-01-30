# frozen_string_literal: true

require_relative '../modules/manufacturer'
require_relative '../modules/instances'

# Поезд
class Train
  include Manufacturer
  include Instances

  # Формат номера: 3 буквы или цифры, необязательный дефис, 2 буквы или цифры
  NUMBER_FORMAT = /^[А-ЯA-Z\d]{3}-?[А-ЯA-Z\d]{2}$/i.freeze

  attr_accessor :station, :previous_station, :route
  attr_reader :carriages, :speed, :number

  def initialize(number)
    @number = number.to_s
    validate!
    @carriages = []
    @speed = 0
    register_instance
  end

  def permitted_type_carriage
    Carriage
  end

  def pick_up_speed
    @speed = default_speed
  end

  def attach_carriage(carriage)
    return print_impossible_attach_detach unless stopped?

    if carriage.is_a?(permitted_type_carriage)
      carriages << carriage
      print_successful_attach
    else
      print_failed_attach
    end
  end

  def detach_carriage
    return print_impossible_attach_detach unless stopped?

    if carriages.pop
      print_successful_detach
    else
      print_failed_detach
    end
  end

  def next_station
    return print_route_not_exist unless route.is_a?(Route)

    # Меняем маршрут в обратную сторону, если сейчас поезд на конечной
    route.list.reverse if final_stop?

    current_station_index = route.list.index(station)
    @next_station = route.list[current_station_index + 1]
  end

  def go_next
    station.send_train(self)
    stop
  end

  def stop
    @speed = 0
  end

  def stopped?
    speed.zero?
  end

  def final_stop?
    station == route.list.last
  end

  def change_number(number)
    @number = number.to_s
  end

  def self.find(number)
    all.find { |train| train.number == number }
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  protected

  attr_writer :number

  # Метод вынесен в protected, потому что используется только
  # другими методами, является вспомогательным и наследуется дочерним классам.
  def print_impossible_attach_detach
    puts 'Невозможно прицеплять и отцеплять вагоны, во время движения.'
  end

  def validate!
    raise 'У поезда должен быть номер' if number.nil? || number.size.zero?
    raise 'Номер должен быть длиной 5 или 6 символов' if number.size != 5 && number.size != 6
    raise 'Неправильный формат номера' if number !~ NUMBER_FORMAT

    true
  end

  def default_speed
    80
  end

  def total_carriages_attached
    "Всего вагонов прицеплено: #{carriages.size}."
  end

  def print_successful_attach
    puts "Прицепили 1 вагон. #{total_carriages_attached}"
  end

  def print_failed_attach
    puts "Не получилось прицепить вагон. #{total_carriages_attached}"
  end

  def print_successful_detach
    puts "Отцепили 1 вагон. #{total_carriages_attached}"
  end

  def print_failed_detach
    puts "Не получилось отцепить вагон. #{total_carriages_attached}"
  end

  def print_route_not_exist
    puts 'Отсутствует маршрут'
  end
end
