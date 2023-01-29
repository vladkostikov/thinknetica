# frozen_string_literal: true

require_relative 'train'

# Грузовой поезд
class CargoTrain < Train
  DEFAULT_SPEED = 80

  def attach_carriage(carriage)
    return puts impossible_attach_detach unless stopped?

    if carriage.instance_of?(CargoCarriage)
      carriages << carriage
      puts "Прицепили 1 вагон. Всего вагонов прицеплено: #{carriages.size}."
    else
      puts 'Не получилось прицепить вагон. К грузовому поезду можно прицеплять ' \
           "только грузовые вагоны. Всего вагонов прицеплено: #{carriages.size}."
    end
  end

  def pick_up_speed
    @speed = DEFAULT_SPEED
  end
end
