require 'active_model'
require 'active_model/validations'

class RnValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    true
  end
end
