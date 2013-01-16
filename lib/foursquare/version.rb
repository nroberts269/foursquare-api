module Foursquare
  class Version
    MAJOR = 0 unless defined? Foursquare::Version::MAJOR
    MINOR = 0 unless defined? Foursquare::Version::MINOR
    PATCH = 6 unless defined? Foursquare::Version::PATCH
    PRE = nil unless defined? Foursquare::Version::PRE

    class << self

      # @return [String]
      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end

    end

  end
end
