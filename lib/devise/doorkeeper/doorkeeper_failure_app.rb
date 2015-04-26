require 'devise/failure_app'
require 'devise/strategies/doorkeeper'

module Devise
  module Doorkeeper
    class DoorkeeperFailureApp < ::Devise::FailureApp
      def respond
        if warden_message == Devise::Strategies::Doorkeeper::WARDEN_INVALID_TOKEN_MESSAGE
          invalid_oauth_token
        else
          super
        end
      end

      private

      def invalid_oauth_token
        error = ::Doorkeeper::OAuth::InvalidTokenResponse.new
        headers.merge! error.headers
        self.response_body = error.body.to_json
        self.status        = error.status
      end
    end
  end
end
