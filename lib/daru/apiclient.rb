require 'httparty'
require 'daru'
require 'daru/apiclient/version'

module Daru
  class APIClientTemplate
    include HTTParty

    def get(*args)
      res = self.class.get(*args)
      create_dataframe res
    end

    def post(*args)
      res = self.class.post(*args)
      create_dataframe res
    end

    def create_dataframe(res)
      peel(res.to_a)
      Daru::DataFrame.new(res.to_a)
    end

    private

    def peel(arg)
      case arg
      when Array
        arg.size == 1 ? peel(arg[0]) : arg
      when Hash
        arg.keys.size == 1 ? peel(arg[arg.keys.first]) : arg
      end
    end
  end

  class APIClient
    def initialize(uri)
      client_class = Class.new(Daru::APIClientTemplate)
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
