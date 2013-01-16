require 'pp'

module Foursquare
  class Node

    def initialize(access_token)
      @access_token = access_token
    end

    def perform_graph_request(endpoint, params={}, method="get")
      require 'net/http'

      @query_string = "?"
      @query_string += "oauth_token=#{CGI.escape(@access_token)}" unless @access_token.empty?
      @query_string += "&v=#{Foursquare.configuration.api_version}" if Foursquare.configuration.api_version

      if method=="get"
        params.each{|key, val| @query_string += "&#{key}=#{val}"}
        url = URI.parse("#{Foursquare.configuration.base_url}#{endpoint}#{@query_string}")
        request = Net::HTTP::Get.new("#{url.path}?#{url.query}",{"Content-Type"=>"text/json"})
      else
        url = URI.parse("#{Foursquare.configuration.base_url}#{endpoint}#{@query_string}")
        request = Net::HTTP::Post.new("#{url.path}?#{url.query}",{"Content-Type"=>"text/json"})
        request.set_form_data(params)
      end

      Rails.logger.debug "Foursquare Request URL: #{url.to_s}" if Foursquare.configuration.debug
      Rails.logger.debug "Foursquare Request: #{PP.pp(request, "")}" if Foursquare.configuration.debug

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      response = JSON.parse(http.start {|http| http.request(request)}.body)

      Rails.logger.debug "Foursquare Response: #{PP.pp(response, "")}" if Foursquare.configuration.debug

      response
    end
  end
  
  def self.exchange_access_token(code, client_id, client_secret, callback)
    require 'net/http'

    callback = CGI.escape(callback)

    url = URI.parse("https://foursquare.com:443/oauth2/access_token?client_id=#{client_id}&client_secret=#{client_secret}&grant_type=authorization_code&redirect_uri=#{callback}&code=#{code}")
    request = Net::HTTP::Get.new("#{url.path}?#{url.query}",{"Content-Type"=>"text/json"})
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    response = JSON.parse(http.start {|http| http.request(request)}.body)
    response['access_token']
  end
end
