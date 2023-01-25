# frozen_string_literal: true

# С этого занятия мы будем создавать приложение, которое поможет диспетчеру
# железнодорожной странции управлять поездами:
# принимать, отправлять, показывать информацию и т.д.(точнее, мы будем создавать его объектную модель).
# Нужно написать:
# Классы Train и RailwayStation, Route для поезда, станции и маршрута соответственно.

# Станция:
# Имеет название, которое указывается при ее создании
# Станция может:
# 1. Принимать поезда
# 2. Показывать список всех поездов на станции, находящиеся в текущий момент
# 3. Показывать список поездов на станции по типу: кол-во грузовых, пассажирских
# 4. Отправлять поезда (при этом, поезд удаляется из списка поездов, находящихся на станции).
class RailwayStation
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def receive_train(train)
    @trains << train
    train.station = self
    train.stop
  end

  def send_train(train)
    trains.delete(train)
    train.previous_station = self
    train.next_station.receive_train(train)
  end

  def trains_info
    passenger_trains = 0
    cargo_trains = 0

    @trains.each do |train|
      passenger_trains += 1 if train.type == :passenger
      cargo_trains += 1 if train.type == :cargo
    end
    "Cтанция #{name}. Пассажирских поездов: #{passenger_trains}, грузовых поездов: #{cargo_trains}."
  end
end

# Маршрут:
# Имеет начальную и конечную станцию, а также список промежуточных станций
# Маршрут может:
# 1. Добавлять станцию в список
# 2. Удалять станцию из списка
# 3. Выводить список всех станций по-порядку от начальной до конечной
class Route
  attr_reader :list

  def initialize
    @list = []
  end

  def add_station(station)
    @list << station
  end

  def delete_station(station)
    list.delete(station)
  end

  def first_station
    @first_station = list.first
  end

  def last_station
    @last_station = list.last
  end
end

# Поезд:
# Имеет, тип, который указывается при создании: грузовой, пассажирский и количество вагонов.
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
  attr_reader :type, :carriages, :speed

  def initialize(type, carriages = 0)
    @type = type
    @carriages = carriages.to_i
    @carriages = 0 if carriages.negative?
    @speed = 0
  end

  def pick_up_speed
    @speed = 100
  end

  def stop
    @speed = 0
  end

  # Добавляем вагон только если поезд не движется
  def attach_carriage
    @carriages += 1 if speed.zero?
  end

  def detach_carriage
    return @carriages = 0 if carriages.zero?

    @carriages -= 1 if speed.zero?
  end

  def next_station
    # Если поезд находится на конечной, то меняем маршрут в обратную сторону
    @route.list.reverse! if @station == @route.list.last

    current_station_index = @route.list.index(@station)
    @next_station = @route.list[current_station_index + 1]
  end

  def go_next
    pick_up_speed
    @station.send_train(self)
  end
end

# Создаём несколько станций, маршрут и поезд, чтобы посмотреть что всё работает правильно
spb = RailwayStation.new('Санкт-Петербург')
moscow = RailwayStation.new('Москва')
voronezh = RailwayStation.new('Воронеж')
rostov = RailwayStation.new('Ростов-на-Дону')
krasnodar = RailwayStation.new('Краснодар')
sochi = RailwayStation.new('Сочи')

route_to_summer = Route.new
route_to_summer.add_station(spb)
route_to_summer.add_station(moscow)
route_to_summer.add_station(voronezh)
route_to_summer.add_station(rostov)
route_to_summer.add_station(krasnodar)
route_to_summer.add_station(sochi)

train = Train.new(:passenger, -10)
train.route = route_to_summer

moscow.receive_train(Train.new(:cargo, 6))
spb.receive_train(train)

15.times do
  train.go_next
  train.attach_carriage
  puts "\nНаш поезд на станции: #{train.station.name}. Сейчас вагонов: #{train.carriages}."
  puts "Предыдущая станция: #{train.previous_station.name}. Следующая станция: #{train.next_station.name}."
  puts train.station.trains_info
end

5.times do
  train.go_next
  train.detach_carriage
  puts "\nНаш поезд на станции: #{train.station.name}. Сейчас вагонов: #{train.carriages}."
  puts "Предыдущая станция: #{train.previous_station.name}. Следующая станция: #{train.next_station.name}."
  puts train.station.trains_info
end
