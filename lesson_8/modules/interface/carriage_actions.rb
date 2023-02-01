# frozen_string_literal: true

require_relative '../../carriage/passenger_carriage'
require_relative '../../carriage/cargo_carriage'

module CarriageActions
  def attach_carriage
    puts 'К какому поезду хотите прицепить вагон?'
    train = ask_train

    train.attach_carriage(PassengerCarriage.new) if train.is_a?(PassengerTrain)
    train.attach_carriage(CargoCarriage.new) if train.is_a?(CargoTrain)
  end

  def detach_carriage
    puts 'От какого поезда хотите отцепить вагон?'
    train = ask_train
    train.detach_carriage
  end
end
