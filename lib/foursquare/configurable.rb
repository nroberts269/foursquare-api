module Foursquare
  module Configurable

    class << self
      attr_accessor :consumer_key, :consumer_secret, :api_version, :endpoint, :debug

      ENDPOINT = "https://api.foursquare.com/v2/"
      def endpoint
        @endpoint || ENDPOINT
      end

      DEBUG = false
      def debug
        @debug || DEBUG
      end

    end

    def configure
      yield self
      self
    end

  end
end
