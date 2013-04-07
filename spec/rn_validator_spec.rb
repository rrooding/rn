require 'spec_helper'

class RnValidatorTest
  include ActiveModel::Validations
  attr_accessor :number
  validates :number, :rn => true
end

describe RnValidator do
  subject { RnValidatorTest.new }

  it 'works' do
    subject.number = '123'
    expect(subject).to be_valid
  end
end
