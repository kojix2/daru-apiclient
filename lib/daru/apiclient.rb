require 'httparty'
require 'daru'
require "daru/apiclient/version"

module Daru
  class APIClient
    include HTTParty

    def initialize(uri)
      self.class.base_uri uri
    end

    def get(*args)
      response = self.class.get(*args)
      Daru::DataFrame.new(response.to_a)
    end

    def post(*args)
      response = self.class.post(*args)
      Daru::DataFrame.new(response.to_a)
    end
  end
end
