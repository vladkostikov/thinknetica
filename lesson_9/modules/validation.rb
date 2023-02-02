# frozen_string_literal: true

module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_reader :validations

    def validate(attribute, type_of_validation, *params)
      @validations ||= []
      @validations << { attribute: attribute,
                        type_of_validation: type_of_validation,
                        params: params }
    end
  end

  module InstanceMethods
    def validate_presence(value)
      raise 'Value is nil' if value.nil?
      raise 'Value is empty' if value.to_s.strip.empty?
    end

    def validate_format(value, format)
      raise 'Invalid format' if value.to_s !~ format
    end

    def validate_type(value, type)
      raise TypeError, 'Value is not a permitted class' unless value.is_a?(type)
    end

    def validate!
      self.class.validations.each do |validation|
        attribute = validation[:attribute]
        type_of_validation = validation[:type_of_validation]
        params = validation[:params]
        value = instance_variable_get("@#{attribute}")
        validation_method = "validate_#{type_of_validation}"

        send validation_method, value, *params
      end
    end

    def valid?
      validate!
      true
    rescue StandardError
      false
    end
  end
end
