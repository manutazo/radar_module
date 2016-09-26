require 'spec_helper'

describe Targeter::API do
  include Rack::Test::Methods

  def app
    Targeter::API
  end

  context 'GET /radar' do
    it 'returns unpermitted method' do
      get 'radar'
      expect(last_response.status).to eq(405)
      expect(JSON.parse(last_response.body)).to eq JSON.parse('{"error": "405 Not Allowed"}')
    end
  end

  context 'POST /radar' do
    context 'no params' do
      it 'returns bad request' do
        post 'radar'
        expect(last_response.status).to eq(400)
        expect(JSON.parse(last_response.body)).to eq JSON.parse('{"error": "attack-mode is missing, radar is missing"}')
      end
    end

    context 'with params' do
      context 'invalid params' do
        it 'returns bad request' do
          post 'radar', id: 1
          expect(last_response.status).to eq(400)
          expect(JSON.parse(last_response.body)).to eq JSON.parse('{"error": "attack-mode is missing, radar is missing"}')
        end
      end

      context 'incomplete params' do
        it 'returns bad request' do
          post 'radar', :'attack-mode' => [], radar: []
          expect(last_response.status).to eq(400)
          expect(JSON.parse(last_response.body)).to eq JSON.parse('{"error": "attack-mode is missing, radar is missing"}')
        end

        it 'returns bad request' do
          post 'radar', :'attack-mode' => ['closest-first']
          expect(last_response.status).to eq(400)
          expect(JSON.parse(last_response.body)).to eq JSON.parse('{"error": "radar is missing"}')
        end

        it 'returns bad request' do
          post 'radar', radar: [{ position: { x: 2, y: 4 }, targets: [{ type: 'Human' }] }]
          expect(last_response.status).to eq(400)
          expect(JSON.parse(last_response.body)).to eq JSON.parse('{"error": "attack-mode is missing"}')
        end

        it 'returns bad request' do
          post 'radar', :'attack-mode' => ['closest-first']
          expect(last_response.status).to eq(400)
          expect(JSON.parse(last_response.body)).to eq JSON.parse('{"error": "radar is missing"}')
        end

        it 'returns bad request' do
          post 'radar', radar: [{ position: { x: 2, y: 4 }, targets: [{ type: 'Human' }] }]
          expect(last_response.status).to eq(400)
          expect(JSON.parse(last_response.body)).to eq JSON.parse('{"error": "attack-mode is missing"}')
        end
      end
    end
  end
end
