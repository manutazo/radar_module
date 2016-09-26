module Targeter
  class API < Grape::API
    version 'v1', using: :header, vendor: 'kyle_reese'
    format :json

    desc 'Receives a targeting request and returns the chosen target(s)'
    params do
      requires 'attack-mode'
      requires 'radar'
    end
    post :radar do
      status 200
      return {}
    end
  end
end
