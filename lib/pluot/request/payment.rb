require 'pluot/request/base'

module Pluot
  module Request
    class Payment < Base

      SUBJECT_SCOPE = '/Payments'

      def find(id)
        get('/:id', :id => id)
      end

      def made_by(contact_id)
        get('?contactId=:contact_id', :contact_id => contact_id)
      end

    end
  end
end
