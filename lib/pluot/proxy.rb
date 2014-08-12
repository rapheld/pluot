require 'pluot/request/contact'
require 'pluot/request/payment'

module Pluot
  module Proxy

    def contacts
      Pluot::Request::Contact.new(self)
    end

    def payments
      Pluot::Request::Payment.new(self)
    end

  end
end
