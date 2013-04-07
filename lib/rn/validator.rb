require 'active_model'
require 'active_model/validations'

class RnValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    check_birthday = options.fetch(:birthday, false)
    birthday_accessor = options.fetch(:birthday_column, :birthday)

    begin
      number = Rn::RegistrationNumber.new(value)

      record.errors.add(attribute, :invalid_registration_number, options) unless number.valid?

      if check_birthday
        birthday = record.send(birthday_accessor)
        record.errors.add(attribute, :no_matching_birthday, options) if number.birthday != birthday
      end
    rescue ArgumentError => e
      record.errors.add(attribute, e.message, options)
    end
  end
end
