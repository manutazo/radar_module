require 'spec_helper'

describe Target do
  describe 'building' do
    context 'insufficient params' do
      it 'returns an error' do
        expect { Target.new }.to raise_error(KeyError)
      end

      it 'returns an error' do
        expect { Target.new(type: 'T1-9') }.to raise_error(KeyError)
      end
    end

    context 'sufficient params' do
      context 'target is human' do
        it 'is successful without damage' do
          expect(Target.new(type: 'Human')).to be_a Target
        end

        it 'is successful with damage' do
          expect(Target.new(type: 'Human', damage: 30)).to be_a Target
        end
      end

      context 'target is non human' do
        it 'is unsuccesful without damage' do
          expect { Target.new(type: 'T1-9') }.to raise_error KeyError
        end

        it 'is successful with damage' do
          expect(Target.new(type: 'T1-9', damage: 30)).to be_a Target
        end
      end
    end
  end

  describe 'validity' do
    Target::TYPES.each do |type|
      context "building a target of type #{type}" do
        it 'is valid' do
          expect(Target.new(type: type, damage: 30).valid?).to eq true
        end
      end
    end

    context 'building a target of non permitted type' do
      it 'is invalid' do
        expect(Target.new(type: 'Predator', damage: 30).valid?).to eq false
      end
    end
  end
end
