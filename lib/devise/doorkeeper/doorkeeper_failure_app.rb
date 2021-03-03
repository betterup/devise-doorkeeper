require 'devise/strategies/doorkeeper'
require 'devise/doorkeeper/unconfirmed_resource_response'

module Devise
  module Doorkeeper
    module DoorkeeperFailureApp
      def respond
        if oauth_error?
          invalid_oauth_token
        elsif unconfirmed_resource?
          unconfirmed_resource
        else
          super
        end
      end

      private

      def oauth_error?
        warden_message == Devise::Strategies::Doorkeeper::WARDEN_INVALID_TOKEN_MESSAGE
      end

      def unconfirmed_resource?
        warden_message == Devise::Strategies::Doorkeeper::WARDEN_UNCONFIRMED_RESOURCE_MESSAGE
      end

      def invalid_oauth_token
        error = ::Doorkeeper::OAuth::InvalidTokenResponse.new
        headers.merge! error.headers
        self.response_body = error.body.to_json
        self.status = error.status
      end

      def unconfirmed_resource
        error = UnconfirmedResourceResponse.new
        headers.merge! error.headers
        self.response_body = error.body.to_json
        self.status = error.status
      end
    end
  end
end
