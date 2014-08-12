require 'faraday'
require 'json'

module Pluot
  module Middleware
    class ParseJson < Faraday::Response::Middleware

      def on_complete(response)
        body = response[:body] or return

        response[:body] =
          begin
            ::JSON.parse(body, symbolize_names: true)
          rescue JSON::ParserError
            body
          end
      end

    end
  end
end
