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

  def initialize(carriages = 0)
    @carriages = carriages.to_i
    @carriages = 0 if carriages.negative?
    @speed = 0
  end

  def attach_carriage
    @carriages += 1 if speed.zero?
    puts "Прицепили 1 вагон. Всего вагонов прицеплено: #{carriages}."
  end

  def detach_carriage
    return @carriages = 0 if carriages.zero?

    @carriages -= 1 if speed.zero?
    puts "Отцепили 1 вагон. Всего вагонов прицеплено: #{carriages}."
  end

  def next_station
    # Если поезд находится на конечной, то меняем маршрут в обратную сторону
    route.list.reverse! if station == route.list.last

    current_station_index = route.list.index(station)
    @next_station = route.list[current_station_index + 1]
  end

  def go_next
    station.send_train(self)
    stop
  end

  protected

  # Метод вынесен в protected, потому что используется только
  # методом go_next после прибытия на станцию и наследуется дочерним классам.
  def stop
    @speed = 0
  end
end
