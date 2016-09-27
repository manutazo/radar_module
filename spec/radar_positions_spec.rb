require 'spec_helper'

describe RadarPositions do
  describe 'building' do
    context 'insufficient params' do
      it 'returns an error' do
        expect { RadarPositions.new }.to raise_error(ArgumentError)
      end
    end

    context 'sufficient params' do
      it 'returns a RadarPositions array' do
        expect(RadarPositions.new([ { position: { x: 3, y: 40 }, targets: [{ type: 'Human' }] }])).to be_a RadarPositions
        expect(RadarPositions.new([ { position: { x: 3, y: 40 }, targets: [{ type: 'Human'} ] } ]).positions.size).to eq 1
      end

      it 'returns an RadarPositions array' do
        expect(RadarPositions.new([
          { position: { x: 3, y: 40 }, targets: [{ type: 'Human' }] },
          { position: { x: 4, y: 41 }, targets: [{ type: 'Human' }] }
        ])).to be_a RadarPositions
        expect(RadarPositions.new([
          { position: { x: 3, y: 40 }, targets: [{ type: 'Human' }] },
          { position: { x: 4, y: 41 }, targets: [{ type: 'Human' }] }
        ]).positions.size).to eq 2
      end
    end
  end

  describe 'validity' do
    context 'valid positions' do
      it 'is valid' do
        expect(RadarPositions.new([
          { position: { x: 3, y: 40 }, targets: [{ type: 'Human' }] }
        ]).valid_positions?).to be true
      end
    end

    context 'invalid positions' do
      it 'is invalid' do
        expect(RadarPositions.new([
          { position: { x: 3, y: 40 }, targets: [{ type: 'Predator', damage: 9000 }] }
        ]).valid_positions?).to be false
      end
    end
  end
end
