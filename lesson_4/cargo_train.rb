# frozen_string_literal: true

require_relative './train'

# Грузовой поезд
class CargoTrain < Train
  def attach_carriage(carriage)
    if carriage.instance_of?(CargoCarriage)
      carriages << carriage
      puts "Прицепили 1 вагон. Всего вагонов прицеплено: #{carriages.size}."
    else
      puts 'Не получилось прицепить вагон. К грузовому поезду можно прицеплять ' \
           "только грузовые вагоны. Всего вагонов прицеплено: #{carriages.size}."
    end
  end

  def detach_carriage
    if speed.zero?
      carriages.pop
      puts "Отцепили 1 вагон. Всего вагонов прицеплено: #{carriages.size}."
    end
  end

  DEFAULT_SPEED = 80

  def pick_up_speed
    @speed = DEFAULT_SPEED
  end
end
