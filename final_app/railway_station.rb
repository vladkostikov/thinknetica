# frozen_string_literal: true

require_relative 'modules/instances'
require_relative 'modules/validation'

# Железнодорожная станция
class RailwayStation
  include Instances
  include Validation

  # 2 символа или больше
  NAME_FORMAT = /.{2,}/

  attr_reader :name, :trains
  validate :name, :presence
  validate :name, :format, NAME_FORMAT

  def initialize(name)
    @name = name.to_s.strip
    validate!
    @trains = []
    register_instance
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

  def info
    passenger_trains = trains.count { |train| train.is_a?(PassengerTrain) }
    cargo_trains = trains.count { |train| train.is_a?(CargoTrain) }

    "Cтанция #{name}. Пассажирских поездов: #{passenger_trains}, грузовых поездов: #{cargo_trains}."
  end

  def print_trains_info
    trains.each_with_index do |train, index|
      puts "\t#{index + 1}. #{train}"
    end
  end

  def each_train(&block)
    trains.each(&block)
  end
end
