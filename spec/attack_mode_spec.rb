require 'spec_helper'

describe AttackMode do
  describe 'building' do
    context 'insufficient params' do
      it 'returns an error' do
        expect { AttackMode.new }.to raise_error(KeyError)
      end
    end

    context 'sufficient params' do
      it 'returns an Attack Mode' do
        expect(AttackMode.new(mode: 'closest-first')).to be_a AttackMode
      end
    end
  end

  describe 'validity' do
    AttackMode::MODES.each do |mode|
      context "building an AttackMode of mode #{mode}" do
        it 'is valid' do
          expect(AttackMode.new(mode: mode).valid?).to eq true
        end
      end
    end

    context 'building an AttackMode of non permitted mode' do
      it 'is invalid' do
        expect(AttackMode.new(mode: 'Predator', damage: 30).valid?).to eq false
      end
    end
  end
end
