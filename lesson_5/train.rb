# frozen_string_literal: true

require_relative './manufacturer'

# Поезд
class Train
  include Manufacturer

  attr_accessor :station, :previous_station, :route
  attr_reader :carriages, :speed, :number

  @@trains = []

  def self.trains
    @@trains
  end

  def initialize
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
    route.list.reverse! if final_stop?

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
    @number = number
  end

  def self.find(number)
    trains.find { |train| train.number == number }
  end

  protected

  attr_writer :number

  # Метод вынесен в protected, потому что используется только
  # другими методами, является вспомогательным и наследуется дочерним классам.
  def impossible_attach_detach
    'Невозможно прицеплять и отцеплять вагоны, во время движения.'
  end
end
