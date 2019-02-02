require 'httparty'
require 'daru'
require "daru/apiclient/version"

module Daru
  class APIClient
    include HTTParty

    attr_accessor :uri
    def initialize(uri)
      @uri = uri
    end

    def get(*args)
      self.class.base_uri uri
      response = self.class.get(*args)
      Daru::DataFrame.new(response.to_a)
    end

    def post(*args)
      self.class.base_uri uri
      response = self.class.post(*args)
      Daru::DataFrame.new(response.to_a)
    end
    
    def hget
      self.class.base_uri uri
      response = self.class.get(*args)
      response.to_h
    end
    
    def hpost
      self.class.base_uri uri
      response = self.class.post(*args)
      response.to_h
    end
  end
end
