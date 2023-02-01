# frozen_string_literal: true

require_relative '../modules/manufacturer'
require_relative '../modules/instances'

# Поезд
class Train
  include Manufacturer
  include Instances

  # Формат номера: 5 букв или цифр в любом порядке,
  # после 3 символа может быть дефис (необязательно)
  NUMBER_FORMAT = /^[А-ЯA-Z\d]{3}-?[А-ЯA-Z\d]{2}$/i.freeze
  FAILED_ATTACH = 'Не получилось прицепить вагон.'\
                  'Вагон такого типа нельзя прицеплять к этому поезду.'
  IMPOSSIBLE_ATTACH_DETACH = 'Невозможно прицеплять и отцеплять вагоны во время движения.'
  DEFAULT_SPEED = 80

  attr_accessor :station, :previous_station, :route
  attr_reader :carriages, :speed, :number

  def self.find(number)
    all.find { |train| train.number == number }
  end

  def self.find_in_all_subclasses(number)
    Train.all.concat(PassengerTrain.all,
                     CargoTrain.all).find { |train| train.number == number }
  end

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

  def attachable_carriage?(carriage)
    carriage.is_a?(permitted_type_carriage)
  end

  def pick_up_speed
    @speed = DEFAULT_SPEED
  end

  def attach_carriage(carriage)
    raise IMPOSSIBLE_ATTACH_DETACH unless stopped?
    raise FAILED_ATTACH unless attachable_carriage?(carriage)

    carriages << carriage
    print_successful_attach
  end

  def detach_carriage
    raise IMPOSSIBLE_ATTACH_DETACH unless stopped?

    if carriages.pop
      print_successful_detach
    else
      print_failed_detach
    end
  end

  def next_station
    return print_route_not_exist unless route.is_a?(Route)

    # Меняем маршрут в обратную сторону, если сейчас поезд на конечной
    route.stations.reverse! if final_stop?

    current_station_index = route.stations.index(station)
    @next_station = route.stations[current_station_index + 1]
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
    station == route.stations.last
  end

  def change_number(number)
    @number = number.to_s
  end

  def valid?
    validate!
  rescue StandardError
    false
  end

  def each_carriage(&block)
    carriages.each(&block)
  end

  protected

  attr_writer :number

  def validate!
    raise 'У поезда должен быть номер' if number.nil? || number.empty?
    raise 'Номер должен быть длиной 5 или 6 символов' unless (5..6).include?(number.size)
    raise 'Неправильный формат номера' if number !~ NUMBER_FORMAT
    raise 'Поезд с таким номером уже существует' if Train.find_in_all_subclasses(number)

    true
  end

  def total_carriages_attached
    "Всего вагонов прицеплено: #{carriages.size}."
  end

  def print_successful_attach
    puts "Прицепили 1 вагон. #{total_carriages_attached}"
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
