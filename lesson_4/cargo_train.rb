# frozen_string_literal: true

require_relative './train'

# Грузовой поезд
class CargoTrain < Train
  DEFAULT_SPEED = 80

  def pick_up_speed
    @speed = DEFAULT_SPEED
  end
end
