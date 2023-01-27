# frozen_string_literal: true

# Станция имеет название, которое указывается при ее создании
# Станция может:
# 1. Принимать поезда
# 2. Показывать список всех поездов на станции, находящиеся в текущий момент
# 3. Показывать список поездов на станции по типу: кол-во грузовых, пассажирских
# 4. Отправлять поезда (при этом, поезд удаляется из списка поездов, находящихся на станции).
class RailwayStation
  attr_reader :name, :trains

  @@stations = []
  def self.stations
    @@stations
  end

  def initialize(name)
    @name = name
    @trains = []
    @@stations << self
  end

  def receive_train(train)
    @trains << train unless @trains.include?(train)
    train.previous_station = train.station
    train.station = self
    train.stop
  end

  def send_train(train)
    trains.delete(train)
    train.previous_station = self
    train.pick_up_speed
    train.next_station.receive_train(train)
  end

  def station_info
    passenger_trains = 0
    cargo_trains = 0

    @trains.each do |train|
      passenger_trains += 1 if train.instance_of?(PassengerTrain)
      cargo_trains += 1 if train.instance_of?(CargoTrain)
    end
    "Cтанция #{name}. Пассажирских поездов: #{passenger_trains}, грузовых поездов: #{cargo_trains}."
  end
end
