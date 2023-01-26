# frozen_string_literal: true

# Задание:
# 1. Разбить программу на отдельные классы(каждый класс в отдельном файле)
# 2. Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя
# для классов, который будет содержать общие методы и свойства
# 3. Определить, какие методы могут быть помещены в private/protected и вынести
# их в такую секцию. В комментарии к методу обосновать, почему он был вынесен в private/protected
require_relative './railway_station'
require_relative './route'
require_relative './passenger_train'
require_relative './cargo_train'

# Создаём несколько станций, маршрут и поезд, чтобы посмотреть что всё работает правильно
spb = RailwayStation.new('Санкт-Петербург')
moscow = RailwayStation.new('Москва')
voronezh = RailwayStation.new('Воронеж')
rostov = RailwayStation.new('Ростов-на-Дону')
krasnodar = RailwayStation.new('Краснодар')
sochi = RailwayStation.new('Сочи')

route_to_summer = Route.new
route_to_summer.add_station(spb)
route_to_summer.add_station(moscow)
route_to_summer.add_station(voronezh)
route_to_summer.add_station(rostov)
route_to_summer.add_station(krasnodar)
route_to_summer.add_station(sochi)

passenger_train = PassengerTrain.new(-10)
passenger_train.route = route_to_summer

moscow.receive_train(CargoTrain.new)
spb.receive_train(passenger_train)

15.times do
  passenger_train.go_next
  puts "\nПоезд прибыл на станцию: #{passenger_train.station.name}."
  puts "Предыдущая станция: #{passenger_train.previous_station.name}. " \
       "Следующая станция: #{passenger_train.next_station.name}."
  passenger_train.attach_carriage
  puts passenger_train.station.trains_info
end

5.times do
  passenger_train.go_next
  puts "\nПоезд прибыл на станцию: #{passenger_train.station.name}."
  puts "Предыдущая станция: #{passenger_train.previous_station.name}. " \
       "Следующая станция: #{passenger_train.next_station.name}."
  passenger_train.detach_carriage
  puts passenger_train.station.trains_info
end
