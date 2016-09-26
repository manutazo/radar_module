require 'spec_helper'

describe AttackModes do
  describe 'building' do
    context 'insufficient params' do
      it 'returns an error' do
        expect { AttackModes.new }.to raise_error(ArgumentError)
      end
    end

    context 'sufficient params' do
      it 'returns an Attack Modes array' do
        expect(AttackModes.new(['closest-first'])).to be_a AttackModes
        expect(AttackModes.new(['closest-first']).modes.size).to eq 1
      end

      it 'returns an Attack Modes array' do
        expect(AttackModes.new(['closest-first', 'priorize-t-x'])).to be_a AttackModes
        expect(AttackModes.new(['closest-first', 'priorize-t-x']).modes.size).to eq 2
      end
    end
  end

  describe 'validity' do
    context 'valid attack modes' do
      it 'is valid' do
        expect(AttackModes.new(['closest-first', 'priorize-t-x']).valid_modes?).to eq true
      end
    end

    context 'invalid attack modes' do
      it 'is invalid' do
        expect(AttackModes.new(['closezt-first', 'priorize-t-x']).valid_modes?).to eq false
      end
    end

    context 'unique attack modes' do
      it 'is valid' do
        expect(AttackModes.new(['closest-first', 'priorize-t-x']).unique_modes?).to eq true
      end
    end

    context 'repeated attack modes' do
      it 'is invalid' do
        expect(AttackModes.new(['closest-first', 'closest-first']).unique_modes?).to eq false
      end
    end

    context 'at least an attack mode' do
      it 'is valid' do
        expect(AttackModes.new(['closest-first']).modes_specified?).to eq true
      end
    end

    context 'repeated attack modes' do
      it 'is invalid' do
        expect(AttackModes.new([]).modes_specified?).to eq false
      end
    end

    context 'compatible modes' do
      it 'is valid' do
        expect(AttackModes.new(['closest-first']).compatible_modes?).to eq true
      end

      it 'is valid' do
        expect(AttackModes.new(['closest-first', 'avoid-crossfire']).compatible_modes?).to eq true
      end
    end

    context 'incompatible modes' do
      it 'is invalid' do
        expect(AttackModes.new(['closest-first', 'furthest-first']).compatible_modes?).to eq false
        expect(AttackModes.new(['furthest-first', 'closest-first']).compatible_modes?).to eq false
      end
    end
  end
end
