# frozen_string_literal: true

require_relative './train'

# Пассажирский поезд
class PassengerTrain < Train
  DEFAULT_SPEED = 150

  def attach_carriage(carriage)
    if carriage.instance_of?(PassengerCarriage)
      carriages << carriage
      puts "Прицепили 1 вагон. Всего вагонов прицеплено: #{carriages.size}."
    else
      puts 'Не получилось прицепить вагон. К пассажирскому поезду можно прицеплять ' \
           "только пассажирские вагоны. Всего вагонов прицеплено: #{carriages.size}."
    end
  end

  def detach_carriage
    if speed.zero?
      if carriages.pop
        puts "Отцепили 1 вагон. Всего вагонов прицеплено: #{carriages.size}."
      else
        puts "Не получилось отцепить вагон. Всего вагонов прицеплено: #{carriages.size}."
      end
    end
  end

  def pick_up_speed
    @speed = DEFAULT_SPEED
  end
end
