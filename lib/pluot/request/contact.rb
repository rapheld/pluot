require 'pluot/request/base'

module Pluot
  module Request
    class Contact < Base

      SUBJECT_SCOPE = '/Contacts'

      def all
        get('?$async=false')
      end

      def count
        get('?$count')
      end

      def find(id)
        get('/:id', :id => id)
      end

      def filter(conditions)
        get('?$async=false&$filter=:conditions', :conditions => conditions)
      end

    end
  end
end
