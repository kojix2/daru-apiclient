require 'httparty'
require 'daru'
require 'daru/apiclient/version'

module Daru
  class BaseAPIClient
    include HTTParty

    def get(*args)
      response = self.class.get(*args)
      Daru::DataFrame.new(response.to_a)
  end

    def post(*args)
      response = self.class.post(*args)
      Daru::DataFrame.new(response.to_a)
    end
  end

  class APIClient
    def initialize(uri)
      client_class = Class.new(Daru::BaseAPIClient)
      client_class.base_uri uri
      @c = client_class.new
    end

    def get(*args)
      @c.get(*args)
    end

    def post(*args)
      @c.post(*args)
    end

    def hget(*args)
      @c.class.get(*args).to_h
    end

    def hpost(*args)
      @c.class.post(*args).to_h
    end

    def c
      @c.class
    end
  end
end
