# frozen_string_literal: true

# Поезд имеет тип, который указывается при создании: грузовой, пассажирский и количество вагонов.
# Поезд может делать следующие вещи:
# 1. набирать скорость
# 2. показывать текущую скорость
# 3. тормозить
# 4. показывать количество вагонов
# 5. прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто
# увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может
# осуществляться только если поезд не движется.
# 6. Принимать маршрут следования
# 7. Перемещаться между станциями, указанными в маршруте.
# 8. Показывать предыдущую станцию, текущую, следующую, на основе маршрута
class Train
  attr_accessor :station, :previous_station, :route
  attr_reader :carriages, :speed

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

  protected

  # Метод вынесен в protected, потому что используется только
  # другими методами, является вспомогательным и наследуется дочерним классам.
  def impossible_attach_detach
    'Невозможно прицеплять и отцеплять вагоны, во время движения.'
  end
end
