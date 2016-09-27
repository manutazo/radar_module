# This file is used by Rack-based servers to start the application.
require 'grape'
require 'json'

Dir["#{File.dirname(__FILE__)}/api/*.rb"].each { |f| require f }

run Targeter::API
