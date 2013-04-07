require 'spec_helper'

class RnValidatorBase
  include ActiveModel::Validations
  attr_accessor :number
end

class RnValidatorTest < RnValidatorBase
  validates :number, :rn => true
end

class RnValidatorBirthday < RnValidatorBase
  attr_accessor :birthday
  validates :number, :rn => { :birthday => true }
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

  context 'with birthday check' do
    subject { RnValidatorBirthday.new }

    before do
      subject.number = '86100500176'
    end

    context 'with matching birthday' do
      before do
        subject.birthday = Date.parse('05-10-1986')
      end

      it 'is valid' do
        expect(subject).to be_valid
      end
    end

    context 'with different birthday' do
      before do
        subject.birthday = Date.parse('06-10-1986')

        subject.valid?
      end

      it 'is invalid' do
        expect(subject).to_not be_valid
      end

      it 'adds an error on :number' do
        expect(subject.errors[:number]).to be_present
      end
    end

    context 'with empty birthday' do
      before do
        subject.birthday = nil

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
end
