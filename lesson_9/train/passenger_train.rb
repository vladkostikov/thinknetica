# frozen_string_literal: true

require_relative 'train'

# Пассажирский поезд
class PassengerTrain < Train
  DEFAULT_SPEED = 150

  def permitted_type_carriage
    PassengerCarriage
  end

  private

  def print_failed_attach
    puts 'Не получилось прицепить вагон. К пассажирскому поезду можно прицеплять ' \
         "только пассажирские вагоны. #{total_carriages_attached}"
  end
end
