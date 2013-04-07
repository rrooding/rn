require 'date'

module Rn
  class RegistrationNumber
    def initialize(registration_number)
      raise ArgumentError.new('cannot be empty') if registration_number.nil? || registration_number.empty?
      raise ArgumentError.new('must be 11 characters') if registration_number.length != 11
      raise ArgumentError.new('can only contain 0-9') unless (registration_number =~ /\D/).nil?

      @number = registration_number

      @year, @month, @day, @follow, @control = @number.scan(/\A(\d{2})(\d{2})(\d{2})(\d{3})(\d{2})\z/).flatten
    end

    def birthday
      @birthday ||= parse_birthday
    end

    def valid?
      pre_2000_control? || post_2000_control?
    end

    private

    def parse_birthday
      base = pre_2000_control? ? 1900 : 2000
      Date.new(@year.to_i + base, @month.to_i, @day.to_i)
    end

    def pre_2000_control?
      @control.to_i == 97 - (control_sequence.to_i % 97)
    end

    def post_2000_control?
      @control.to_i == 97 - (extended_control_sequence.to_i % 97)
    end

    def control_sequence
      [@year, @month, @day, @follow].join
    end

    def extended_control_sequence
      ['2', control_sequence].join
    end
  end
end
