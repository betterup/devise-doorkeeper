require 'devise/strategies/doorkeeper'

module Devise
  module Doorkeeper
    class UnconfirmedResourceResponse < ::Doorkeeper::OAuth::ErrorResponse
      def initialize(attributes = {})
        super(attributes.merge(name: :unconfirmed_resource, state: :locked))
      end

      def status
        :locked
      end

      def exception_class
        ::Doorkeeper::Errors::DoorkeeperError
      end
    end
  end
end
