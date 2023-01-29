# frozen_string_literal: true

# Модуль для подсчёта количества экземляров класса
module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def instances
      @instances ||= 0
    end

    def add_instance
      instances # вызываем чтобы установить начальное значение @instances = 0
      @instances += 1
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.add_instance
    end
  end
end
