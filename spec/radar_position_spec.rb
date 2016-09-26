require 'spec_helper'

describe RadarPosition do
  describe 'building' do
    context 'insufficient params' do
      it 'returns an error' do
        expect { RadarPosition.new }.to raise_error(KeyError)
      end

      it 'returns an error' do
        expect { RadarPosition.new(position: { x: 3, y: 40 }) }.to raise_error(KeyError)
      end

      it 'returns an error' do
        expect { RadarPosition.new(targets: [{ type: 'Human' }]) }.to raise_error(KeyError)
      end
    end

    context 'sufficient params' do
      subject { RadarPosition.new(position: { x: 3, y: 40 }, targets: [{ type: 'Human' }]) }
      it 'builds a position' do
        expect(subject).to be_a RadarPosition
      end
    end

    context 'with string coordinates' do
      subject { RadarPosition.new(position: { x: '3', y: '40' }, targets: [{ type: 'Human' }]) }
      it 'builds a position' do
        expect(subject).to be_a RadarPosition
        expect(subject.coordinates[:x]).to eq 3
        expect(subject.coordinates[:y]).to eq 40
      end
    end
  end

  describe 'validity' do
    context 'building a RadarPosition with valid targets' do
      subject { RadarPosition.new(position: { x: 3, y: 40 }, targets: [{ type: 'Human' }]) }
      it 'is valid' do
        expect(subject.valid?).to eq true
      end
    end

    context 'building a RadarPosition with invalid targets' do
      subject { RadarPosition.new(position: { x: 3, y: 40 }, targets: [{ type: 'Predator', damage: 40 }]) }
      it 'is invalid' do
        expect(subject.valid?).to eq false
      end
    end
  end
end
