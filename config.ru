# This file is used by Rack-based servers to start the application.

require_relative "config/environment"

run Rails.application
Rails.application.load_server

use Rack::Session::Cookie, secret: File.read(".session.key"), same_site: true, max_age: 86400

