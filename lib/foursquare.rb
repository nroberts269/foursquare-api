require 'foursquare/node'
require 'foursquare/checkins'
require 'foursquare/photo'
require 'foursquare/settings'
require 'foursquare/tips'
require 'foursquare/user'
require 'foursquare/venue'

module Foursquare
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Configuration
    attr_accessor :consumer_key, :consumer_secret, :api_version, :base_url, :debug

    def initialize
      @consumer_key = nil
      @consumer_secret = nil
      @api_version = nil
      @base_url = "https://api.foursquare.com/v2/"
      @debug = false
    end

  end
end
