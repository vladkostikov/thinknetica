# frozen_string_literal: true

require_relative 'train'

# Грузовой поезд
class CargoTrain < Train
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def permitted_type_carriage
    CargoCarriage
  end

  def to_s
    "Грузовой поезд с номером: #{number}. #{total_carriages_attached}"
  end

  private

  def print_failed_attach
    puts 'Не получилось прицепить вагон. К грузовому поезду можно прицеплять ' \
         "только грузовые вагоны. #{total_carriages_attached}"
  end
end
