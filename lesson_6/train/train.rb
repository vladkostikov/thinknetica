# frozen_string_literal: true

require_relative '../modules/manufacturer'

# Поезд
class Train
  include Manufacturer

  # Формат номера: 3 буквы или цифры, необязательный дефис, 2 буквы или цифры
  NUMBER_FORMAT = /^[А-ЯA-Z\d]{3}-?[А-ЯA-Z\d]{2}$/i.freeze

  attr_accessor :station, :previous_station, :route
  attr_reader :carriages, :speed, :number

  @@trains = []

  def self.trains
    @@trains
  end

  def initialize(number)
    @number = number.to_s
    validate!
    @carriages = []
    @speed = 0
    @@trains << self
  end

  def attach_carriage(carriage)
    return puts impossible_attach_detach unless stopped?

    if carriage.instance_of?(Carriage)
      carriages << carriage
      puts "Прицепили 1 вагон. Всего вагонов прицеплено: #{carriages.size}."
    else
      puts 'Не получилось прицепить вагон.' \
           "Всего вагонов прицеплено: #{carriages.size}."
    end
  end

  def detach_carriage
    return puts impossible_attach_detach unless stopped?

    if carriages.pop
      puts "Отцепили 1 вагон. Всего вагонов прицеплено: #{carriages.size}."
    else
      puts "Не получилось отцепить вагон. Всего вагонов прицеплено: #{carriages.size}."
    end
  end

  def next_station
    return puts 'Следующая станция неизвестна, так как нет маршрута.' unless route.instance_of?(Route)

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
    trains.find { |train| train.number == number }
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
  def impossible_attach_detach
    'Невозможно прицеплять и отцеплять вагоны, во время движения.'
  end

  def validate!
    raise 'У поезда должен быть номер' if number.nil? || number.size.zero?
    raise 'Номер должен быть длиной 5 или 6 символов' if number.size != 5 && number.size != 6
    raise 'Неправильный формат номера' if number !~ NUMBER_FORMAT

    true
  end
end
