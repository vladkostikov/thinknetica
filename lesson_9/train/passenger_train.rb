# frozen_string_literal: true

require_relative 'train'

# Пассажирский поезд
class PassengerTrain < Train
  DEFAULT_SPEED = 150

  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def permitted_type_carriage
    PassengerCarriage
  end

  def to_s
    "Пассажирский поезд с номером: #{number}. #{total_carriages_attached}"
  end

  private

  def print_failed_attach
    puts 'Не получилось прицепить вагон. К пассажирскому поезду можно прицеплять ' \
         "только пассажирские вагоны. #{total_carriages_attached}"
  end
end
