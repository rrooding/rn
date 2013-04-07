require 'active_model'
require 'active_model/validations'

class RnValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    begin
      number = Rn::RegistrationNumber.new(value)

      record.errors.add(attribute, :invalid_registration_number, options) unless number.valid?
    rescue ArgumentError => e
      record.errors.add(attribute, e.message, options)
    end
  end
end
