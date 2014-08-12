module Pluot
  module Request
    class Base

      ACCOUNT_SCOPE = '/Accounts/:account_id'

      attr_reader :client

      def initialize(client)
        @client = client
      end

      def get(template = '', values = {})
        client.get(url(template, values))
      end

      private

      def url(template, values)
        [account_scope, subject_scope, query(template, values)].join
      end

      def subject_scope
        self.class.const_get(self.class.name + '::SUBJECT_SCOPE')
      end

      def query(template, values)
        return template if values.empty?

        values.each { |k,v| template.gsub!("\:#{k}", v.to_s) }
        template
      end

      def account_scope
        ACCOUNT_SCOPE.gsub(/:account_id/, client.account_id.to_s)
      end

    end
  end
end
