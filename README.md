[![Build Status](https://travis-ci.org/betterup/devise-doorkeeper.svg)](https://travis-ci.org/betterup/devise-doorkeeper)
# Devise::Doorkeeper
> Integrates OAuth2 tokens from the Doorkeeper gem into Devise authentication strategies

## Devise/Doorkeeper Integration
[Devise](https://github.com/plataformatec/devise) and [Doorkeeper](https://github.com/doorkeeper-gem/doorkeeper)
are complimentary gems.  Doorkeeper's job is to
dispense OAuth2 tokens and Devise's job is to ensure your resources are protected from
unauthenticated requests.

The devise-doorkeeper gem allows your existing Devise application to accept OAuth2 tokens
created by the Doorkeeper authorization flow.

This means you do *not* need to update your controllers to use the `doorkeeper_authorize!`
filter and can use the standard Devise `authenticate_user!` methods instead.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'devise-doorkeeper'
```

## Configuration

#### Update doorkeeper config
Update your `config/initializers/doorkeeper.rb` to call
`Devise::Doorkeeper.configure(self)`.

```ruby
# config/initializers/doorkeeper.rb
Doorkeeper.configure do
  Devise::Doorkeeper.configure(self)

  # extra configuration goes below
end
```

#### Add `:doorkeeper` to your list of devise modules

```ruby
# example app/models/user.rb
class User
  devise :doorkeeper
end
```

#### Ensure controllers have authentication enabled

```ruby
# example app/controllers/comments_controller.rb
class CommentsController < ApplicationController
  before_action :authenticate_user!

  def index
    # this action is protected
    # the devise-doorkeeper gem will permit access via valid OAuth2 tokens
  end
end
```

## [ Contributing ](CONTRIBUTING.md)

1. Fork it ( https://github.com/betterup/devise-doorkeeper/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
