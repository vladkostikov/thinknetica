# frozen_string_literal: true

# Модуль для сохранения экземляров класса в переменную и доступа к ней через all
module Instances
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def all
      instances
    end

    def instances
      @instances ||= []
    end

    def add_instance(instance)
      instances # вызываем чтобы установить начальное значение @instances = []
      @instances << instance
    end
  end

  module InstanceMethods
    private

    def register_instance
      self.class.add_instance(self)
    end
  end
end
