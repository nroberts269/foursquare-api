require 'foursquare/configurable'
require 'foursquare/default'
require 'foursquare/node'
require 'foursquare/checkins'
require 'foursquare/photo'
require 'foursquare/settings'
require 'foursquare/tips'
require 'foursquare/user'
require 'foursquare/venue'

module Foursquare
  class << self
    include Foursquare::Configurable
  end
end

Foursquare.setup