require 'devise/doorkeeper/version'
require 'devise/strategies/doorkeeper'
require 'devise/doorkeeper/doorkeeper_failure_app'

module Devise
  module Doorkeeper
    # configure devise to support doorkeeper error responses
    def self.configure_devise(config)
      Devise::FailureApp.prepend(Devise::Doorkeeper::DoorkeeperFailureApp)
    end

    # configure doorkeeper to use devise authentication
    def self.configure_doorkeeper(base)
      base.instance_eval do
        resource_owner_authenticator do
          current_user || warden.authenticate!(scope: :user)
        end

        # configure doorkeeper to use devise database authenticatable plugin
        resource_owner_from_credentials do
          user = User.find_for_database_authentication(email: params[:username])
          if user && user.valid_for_authentication? { user.valid_password?(params[:password]) }
            user
          else
            nil
          end
        end
      end
    end
  end
end
