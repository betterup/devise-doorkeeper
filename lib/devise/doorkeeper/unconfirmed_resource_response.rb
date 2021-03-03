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

      def description
        @description ||= I18n.translate('doorkeeper.errors.messages.unconfirmed_resource')
      end

      def exception_class
        ::Doorkeeper::Errors::DoorkeeperError
      end
    end
  end
end
