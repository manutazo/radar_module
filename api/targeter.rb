module Targeter
  class API < Grape::API
    version 'v1', using: :header, vendor: 'kyle_reese'
    format :json

    desc 'Receives a targeting request and returns the chosen target(s)'
    params do
      requires 'attack-mode', type: AttackModes,
                              desc: 'Attack mode(s)',
                              coerce_with: ->(modes) { AttackModes.parse(modes) }

      requires 'radar', type: RadarPositions,
                        desc: 'Radar position(s)',
                        coerce_with: ->(positions) { RadarPositions.parse(positions) }
    end
    post :radar do
      status 200
      return {}
    end
  end
end
