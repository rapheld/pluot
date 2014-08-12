require 'pluot/client'
require 'pluot/middleware/parse_json'
require 'pluot/version'
require 'forwardable'

module Pluot
  class << self
    extend Forwardable

    attr_accessor :api_key, :account_id

    delegate [:contacts, :payments] => :client

    private

    def client
      @client ||= Pluot::Client.new(api_key, account_id)
    end

  end

  Faraday::Response.register_middleware(:response, {
    pluot_parse_json: Pluot::Middleware::ParseJson
  })

end
