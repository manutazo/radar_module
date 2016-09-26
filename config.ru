# This file is used by Rack-based servers to start the application.
require 'grape'

require_relative 'targeter'

run Targeter::API
