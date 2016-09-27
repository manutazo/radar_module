require 'spec_helper'

describe PositionsFilter do
  describe 'attack-mode includes avoid-crossfire' do
    context 'Position has humans' do
      it 'removes the positions with humans' do
        modes         = ['avoid-crossfire']
        coordinates_a = { x: 1, y: 2 }
        coordinates_b = { x: 2, y: 4 }
        human_target  = { type: 'Human' }
        tx_target     = { type: 'T-X', damage: 90 }
        position_without_humans = { position: coordinates_a, targets: [tx_target] }
        position_with_humans    = { position: coordinates_b, targets: [human_target] }
        positions = [position_without_humans, position_with_humans]

        attack_modes    = AttackModes.new(modes)
        radar_positions = RadarPositions.new(positions)

        result = PositionsFilter.new(modes: attack_modes, radar: radar_positions).filter

        expect(result.has_humans?).to eq false
        expect(JSON.parse(result.to_json)).to eq JSON.parse({ position: coordinates_a, targets: ['T-X'] }.to_json)
      end
    end
  end

  describe 'attack-mode includes closst-first' do
    it 'gets the closest position' do
      modes          = ['closest-first']
      coord_close    = { x: 1, y: 2 }
      coord_far      = { x: 2, y: 4 }
      human_target   = { type: 'Human' }
      tx_target      = { type: 'T-X', damage: 90 }
      position_close = { position: coord_close, targets: [tx_target] }
      position_far   = { position: coord_far, targets: [human_target] }
      positions = [position_close, position_far]

      attack_modes    = AttackModes.new(modes)
      radar_positions = RadarPositions.new(positions)

      result = PositionsFilter.new(modes: attack_modes, radar: radar_positions).filter

      expect(JSON.parse(result.to_json)).to eq JSON.parse({ position: coord_close, targets: ['T-X'] }.to_json)
    end
  end

  describe 'attack-mode includes further-first' do
    it 'gets the furthest position' do
      modes          = ['furthest-first']
      coord_close    = { x: 1, y: 2 }
      coord_far      = { x: 2, y: 4 }
      t1_target      = { type: 'T1-9', damage: 120 }
      tx_target      = { type: 'T-X', damage: 90 }
      position_close = { position: coord_close, targets: [tx_target] }
      position_far   = { position: coord_far, targets: [t1_target] }
      positions = [position_close, position_far]

      attack_modes    = AttackModes.new(modes)
      radar_positions = RadarPositions.new(positions)

      result = PositionsFilter.new(modes: attack_modes, radar: radar_positions).filter

      expect(JSON.parse(result.to_json)).to eq JSON.parse({ position: coord_far, targets: ['T1-9'] }.to_json)
    end
  end
end
