require 'forwardable'

module Foursquare
  module Configurable
    extend Forwardable
    attr_writer :consumer_key, :consumer_secret, :api_version, :debug
    attr_accessor :endpoint
    def_delegator :options, :hash

    class << self
      def keys
        @keys ||= [
            :consumer_key,
            :consumer_secret,
            :api_version,
            :debug
        ]
      end
    end

    def configure
      yield self
      self
    end

    def reset!
      Foursquare::Configurable.keys.each do |key|
        instance_variable_set(:"@#{key}", Foursquare::Default.options[key])
      end
      self
    end
    alias setup reset!

    # @return [Hash]
    def options
      Hash[Foursquare::Configurable.keys.map{|key| [key, instance_variable_get(:"@#{key}")]}]
    end


  end
end
