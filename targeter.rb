module Targeter
  class API < Grape::API
    version 'v1', using: :header, vendor: 'kyle_reese'
    format :json

    desc 'Receives a targeting request and returns the chosen target(s)'
    params do
    end
    post :radar do
    end
  end
end
