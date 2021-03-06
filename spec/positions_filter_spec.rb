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
        positions = [position_with_humans, position_without_humans]

        attack_modes    = AttackModes.new(modes)
        radar_positions = RadarPositions.new(positions)

        result = PositionsFilter.new(modes: attack_modes, radar: radar_positions).filter

        expect(result.has_humans?).to eq false
        expect(JSON.parse(result.formatted_result.to_json)).to eq JSON.parse({ position: coordinates_a, targets: ['T-X'] }.to_json)
      end
    end
  end

  describe 'attack-mode includes closest-first' do
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

      result = PositionsFilter.new(modes: attack_modes, radar: radar_positions).filter.formatted_result

      expect(JSON.parse(result.to_json)).to eq JSON.parse({ position: coord_close, targets: ['T-X'] }.to_json)
    end
  end

  describe 'attack-mode includes furthest-first' do
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

      result = PositionsFilter.new(modes: attack_modes, radar: radar_positions).filter.formatted_result

      expect(JSON.parse(result.to_json)).to eq JSON.parse({ position: coord_far, targets: ['T1-9'] }.to_json)
    end
  end

  describe 'attack-mode includes priorize-t-x' do
    it 'gets the position with t-x' do
      modes          = ['priorize-t-x']
      coord_tx    = { x: 1, y: 2 }
      coord_t1      = { x: 2, y: 4 }
      t1_target      = { type: 'T1-9', damage: 120 }
      tx_target      = { type: 'T-X', damage: 90 }
      position_tx    = { position: coord_tx, targets: [t1_target, tx_target] }
      position_t1    = { position: coord_tx, targets: [t1_target] }
      positions = [position_tx, position_t1]

      attack_modes    = AttackModes.new(modes)
      radar_positions = RadarPositions.new(positions)

      result = PositionsFilter.new(modes: attack_modes, radar: radar_positions).filter.formatted_result
      json   = JSON.parse({ position: coord_tx, targets: ['T-X', 'T1-9']}.to_json)
      expect(JSON.parse(result.to_json)).to eq json
    end
  end

  describe 'multiple attack-modes' do
    it 'first filters, then gets the result chosen by distance' do
      modes          = ['furthest-first', 'avoid-crossfire']
      coord_tx       = { x: 1, y: 2 }
      coord_t1       = { x: 2, y: 4 }
      coord_human    = { x: 3, y: 6 }
      t1_target      = { type: 'T1-9', damage: 120 }
      tx_target      = { type: 'T-X', damage: 90 }
      human_target   = { type: 'Human' }
      position_tx    = { position: coord_tx, targets: [t1_target, tx_target] }
      position_t1    = { position: coord_t1, targets: [t1_target, tx_target] }
      position_human = { position: coord_human, targets: [human_target] }
      positions      = [position_tx, position_human, position_t1]

      attack_modes    = AttackModes.new(modes)
      radar_positions = RadarPositions.new(positions)

      result = PositionsFilter.new(modes: attack_modes, radar: radar_positions).filter.formatted_result
      json   = JSON.parse({ position: coord_t1, targets: ['T1-9', 'T-X']}.to_json)
      expect(JSON.parse(result.to_json)).to eq json
    end

    it 'first filters, then gets the result chosen by distance' do
      modes          = ['closest-first', 'priorize-t-x']
      coord_tx       = { x: 1, y: 2 }
      coord_t1       = { x: 2, y: 4 }
      coord_human    = { x: 3, y: 6 }
      t1_target      = { type: 'T1-9', damage: 120 }
      tx_target      = { type: 'T-X', damage: 90 }
      human_target   = { type: 'Human' }
      position_tx    = { position: coord_tx, targets: [t1_target, tx_target] }
      position_t1    = { position: coord_t1, targets: [t1_target, tx_target] }
      position_human = { position: coord_human, targets: [human_target] }
      positions      = [position_tx, position_human, position_t1]

      attack_modes    = AttackModes.new(modes)
      radar_positions = RadarPositions.new(positions)

      result = PositionsFilter.new(modes: attack_modes, radar: radar_positions).filter.formatted_result
      json   = JSON.parse({ position: coord_tx, targets: ['T-X', 'T1-9']}.to_json)
      expect(JSON.parse(result.to_json)).to eq json
    end
  end
end
