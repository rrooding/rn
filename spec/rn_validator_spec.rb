require 'spec_helper'

class RnValidatorBase
  include ActiveModel::Validations
  attr_accessor :number
end

class RnValidatorTest < RnValidatorBase
  validates :number, :rn => true
end

describe RnValidator do
  subject { RnValidatorTest.new }

  context 'valid number' do
    before do
      subject.number = '86100500176'
    end

    it 'is valid' do
      expect(subject).to be_valid
    end
  end

  context 'invalid control' do
    before do
      subject.number = '86100500177' # control + 1

      subject.valid?
    end

    it 'is invalid' do
      expect(subject).to_not be_valid
    end

    it 'adds an error on :number' do
      expect(subject.errors[:number]).to be_present
    end
  end

  context 'invalid number' do
    before do
      subject.number = '1234'

      subject.valid?
    end

    it 'is invalid' do
      expect(subject).to_not be_valid
    end

    it 'adds an error on :number' do
      expect(subject.errors[:number]).to be_present
    end
  end

  context 'blank number' do
    before do
      subject.number = ''

      subject.valid?
    end

    it 'is invalid' do
      expect(subject).to_not be_valid
    end

    it 'adds an error on :number' do
      expect(subject.errors[:number]).to be_present
    end
  end

  context 'nil number' do
    before do
      subject.number = nil

      subject.valid?
    end

    it 'is invalid' do
      expect(subject).to_not be_valid
    end

    it 'adds an error on :number' do
      expect(subject.errors[:number]).to be_present
    end
  end
end
