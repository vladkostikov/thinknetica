# frozen_string_literal: true

require_relative 'train'

# Грузовой поезд
class CargoTrain < Train
  def permitted_type_carriage
    CargoCarriage
  end

  private

  def print_failed_attach
    puts 'Не получилось прицепить вагон. К грузовому поезду можно прицеплять ' \
         "только грузовые вагоны. #{total_carriages_attached}"
  end
end
