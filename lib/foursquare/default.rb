require 'foursquare/configurable'
require 'foursquare/version'

module Foursquare
  module Default
    ENDPOINT = 'https://api.foursquare.com/v2/' unless defined? Foursquare::Default::ENDPOINT
    DEBUG = false unless defined? Foursquare::Default::DEBUG

    class << self

      # @return [Hash]
      def options
        Hash[Foursquare::Configurable.keys.map{|key| [key, send(key)]}]
      end

      # @return [String]
      def consumer_key
        ENV['FOURSQUARE_CONSUMER_KEY']
      end

      # @return [String]
      def consumer_secret
        ENV['FOURSQUARE_CONSUMER_SECRET']
      end

      # @return [String]
      def api_version
        ENV['FOURSQUARE_API_VERSION']
      end

      # @return [Boolean]
      def debug
        DEBUG
      end

      # @return [String]
      def endpoint
        ENDPOINT
      end

    end
  end
end
