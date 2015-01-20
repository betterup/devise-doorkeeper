require 'warden'
require 'doorkeeper'
require 'devise'
require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    class Doorkeeper < ::Devise::Strategies::Authenticatable
      def valid?
        credentials = ::Doorkeeper::OAuth::Token.from_request(request, *access_token_methods)
        credentials.present?
      end

      def authenticate!
        resource = resource_from_token
        if validate(resource)
          success!(resource)
        else
          invalid_token
        end
      end

      private

      def resource_from_token
        token = ::Doorkeeper.authenticate(request)
        scopes = ::Doorkeeper.configuration.default_scopes
        invalid_token unless token && token.acceptable?(scopes)
        mapping.to.find(token.resource_owner_id)
      end

      def invalid_token
        fail!(:invalid_token)
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


# if ///
#  error = OAuth::InvalidTokenResponse.from_access_token(doorkeeper_token)
#   options = doorkeeper_unauthorized_render_options
# else
#   error = OAuth::ForbiddenTokenResponse.from_scopes(scopes)
#   options = doorkeeper_forbidden_render_options
# end
