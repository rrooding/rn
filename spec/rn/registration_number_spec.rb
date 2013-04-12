require 'spec_helper'

describe Rn::RegistrationNumber do
  subject { described_class.new(number) }

  let(:number) { '86100500176' }

  context 'invalid arguments' do
    describe 'nil' do
      it 'raises an argument error' do
        expect { described_class.new(nil) }.to raise_error(ArgumentError, 'cannot be empty')
      end
    end

    describe 'empty string' do
      it 'raises an argument error' do
        expect { described_class.new('') }.to raise_error(ArgumentError, 'cannot be empty')
      end
    end

    describe 'with non numeric characters' do
      it 'raises an argument error' do
        expect { described_class.new('1234567aa89') }.to raise_error(ArgumentError, 'can only contain 0-9')
      end
    end

    describe 'too short' do
      it 'raises an argument error' do
        expect { described_class.new('1234567890') }.to raise_error(ArgumentError, 'must be 11 characters')
      end
    end

    describe 'too long' do
      it 'raises an argument error' do
        expect { described_class.new('123456789012') }.to raise_error(ArgumentError, 'must be 11 characters')
      end
    end
  end

  describe '#birthday' do
    context '< 2000' do
      it 'is extracted' do
        expect(subject.birthday).to eq Date.parse('05-10-1986')
      end
    end

    context '= 2000' do
      let(:number) { '00100500145' }

      it 'is extracted' do
        expect(subject.birthday).to eq Date.parse('05-10-2000')
      end
    end

    context '> 2000' do
      let(:number) { '10100500161' }

      it 'is extracted' do
        expect(subject.birthday).to eq Date.parse('05-10-2010')
      end
    end
  end

  describe '#sex' do
    context 'male' do
      it 'returns :male' do
        expect(subject.sex).to eq :male
      end
    end

    context 'female' do
      let(:number) { '86100500276' }

      it 'returns :female' do
        expect(subject.sex).to eq :female
      end
    end
  end

  describe '#valid?' do
    context '< 2000' do
      context 'valid registration number' do
        it 'returns true' do
          expect(subject).to be_valid
        end
      end

      context 'invalid registration number' do
        let(:number) { '86100500177' } # control + 1

        it 'returns false' do
          expect(subject).to_not be_valid
        end
      end
    end

    context '= 2000' do
      context 'valid registration number' do
        let(:number) { '00100500145' }

        it 'returns true' do
          expect(subject).to be_valid
        end
      end

      context 'invalid registration number' do
        let(:number) { '00100500146' } # control + 1

        it 'returns false' do
          expect(subject).to_not be_valid
        end
      end
    end

    context '> 2000' do
      context 'valid registration number' do
        let(:number) { '10100500161' }

        it 'returns true' do
          expect(subject).to be_valid
        end
      end

      context 'invalid registration number' do
        let(:number) { '10100500162' } # control + 1

        it 'returns false' do
          expect(subject).to_not be_valid
        end
      end
    end
  end
end
