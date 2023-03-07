# frozen_string_literal: true

module Accessors
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def attr_accessor_with_history(*attributes)
      attributes.each do |attribute|
        raise TypeError, 'Attribute name is not a symbol' unless attribute.is_a?(Symbol)

        variable = "@#{attribute}"
        history_variable = "@#{attribute}_history"

        define_method(attribute) do
          instance_variable_get(variable)
        end

        define_method("#{attribute}_history") do
          instance_variable_get(history_variable)
        end

        define_method("#{attribute}=") do |value|
          history = instance_variable_get(history_variable)

          if history
            old_value = instance_variable_get(variable)
            history.push(old_value)
          else
            instance_variable_set(history_variable, [])
          end

          instance_variable_set(variable, value)
        end
      end
    end

    def strong_attr_accessor(attribute, permitted_class)
      raise TypeError, 'Attribute name is not a symbol' unless attribute.is_a?(Symbol)

      variable = "@#{attribute}"

      define_method(attribute) do
        instance_variable_get(variable)
      end

      define_method("#{attribute}=") do |value|
        raise TypeError, 'Value is not a permitted class' unless value.is_a?(permitted_class)

        instance_variable_set(variable, value)
      end
    end
  end
end
