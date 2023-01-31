# frozen_string_literal: true

require_relative 'modules/instances'

# Железнодорожная станция
class RailwayStation
  include Instances

  attr_reader :name, :trains

  def initialize(name)
    @name = name.to_s
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

  def valid?
    validate!
  rescue StandardError
    false
  end

  def each_train
    trains.each do |train|
      yield(train)
    end
  end

  protected

  def validate!
    raise 'У станции должно быть название' if name.nil? || name.size.zero?
    raise 'Название станции должно состоять как минимум из 2 символов' if name.size < 2

    true
  end
end
