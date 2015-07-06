require 'warden'
require 'doorkeeper'
require 'devise'
require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class Doorkeeper < ::Devise::Strategies::Authenticatable
      WARDEN_INVALID_TOKEN_MESSAGE = :invalid_token

      def valid?
        credentials = ::Doorkeeper::OAuth::Token.from_request(request, *access_token_methods)
        credentials.present?
      end

      def authenticate!
        resource = resource_from_token
        if validate(resource)
          request.env['devise.skip_trackable'] = true
          success!(resource)
        else
          invalid_token
        end
      end

      # override base class implementation
      # allow for Rails application to configure
      # skipping session storage for doorkeeper requests
      # see Devise skip_session_storage configuration
      def authentication_type
        :doorkeeper
      end

      # override base class implementation
      # API requests should *not* reset the user's
      # CSRF token which triggers rails to set the
      # session_id key and send cookies to users
      def clean_up_csrf?
        false
      end

      private

      def resource_from_token
        token = ::Doorkeeper.authenticate(request)
        scopes = ::Doorkeeper.configuration.default_scopes
        invalid_token unless token && token.acceptable?(scopes)
        mapping.to.find(token.resource_owner_id)
      end

      def invalid_token
        fail!(WARDEN_INVALID_TOKEN_MESSAGE)
        throw :warden
      end

      def access_token_methods
        ::Doorkeeper.configuration.access_token_methods
      end
    end
  end
end
Warden::Strategies.add(:doorkeeper, Devise::Strategies::Doorkeeper)
Devise.add_module(:doorkeeper, strategy: true)
