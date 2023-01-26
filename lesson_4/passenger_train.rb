# frozen_string_literal: true

require_relative './train'

# Пассажирский поезд
class PassengerTrain < Train
  DEFAULT_SPEED = 150

  def pick_up_speed
    @speed = DEFAULT_SPEED
  end
end
