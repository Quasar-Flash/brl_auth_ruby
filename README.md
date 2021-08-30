# brl_auth_ruby

Módulo de autenticação para API da BRL para projetos em Ruby

[![Gem Version](https://badge.fury.io/rb/brl_auth.svg)](https://badge.fury.io/rb/brl_auth)
[![brl_auth](https://github.com/Quasar-Flash/brl_auth_ruby/actions/workflows/ruby.yml/badge.svg)](https://github.com/Quasar-Flash/brl_auth_ruby/actions/workflows/ruby.yml)

## Dev Requirements

- Ruby: Any version
- Bundler

## Global Installation

```ruby
gem install brl_auth
```

## Installation for Rails

```ruby
# Add to the Gemfile
gem "brl_auth", "~> 0.1.0"
```

## Setting the BRL credentials - Rails Project

Create the config/initializers/brl.rb file and define:

```ruby
# Set the env variables
BRL.configure do |config|
  config.auth_url_value = "https://xxx.hmra.com.br" # optional; default: https://hom.api.acesso.hmra.com.br
  config.handshake = "XXXXXX-XXXXX-XXXX"
  config.secret_key = "xxxxxxxxx"
end
```

## Retrieving token

```ruby
require "brl_auth"

BRL::Auth::TokenService.new.retrieve
```

## Result Example

```ruby
#<BRL::Auth::Token:0x00005606d4e9ae40
  @access_token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9",
  @created_at=2021-08-30 21:19:21.428047024 UTC,
  @expires_in=86400,
  @refresh_token="xxxxxxxxxxxxxxxxxxxxxx",
  @scope="refresh_token",
  @token_type="Bearer">
```

## Problems?

**Please do not directly email any committers with questions or problems.**  A
community is best served when discussions are held in public.

Searching the [issues](https://github.com/Quasar-Flash/brl_auth_ruby/issues)
for your problem is also a good idea.

## Contributing

- Check out the latest master to make sure the feature hasn't been implemented
or the bug hasn't been fixed yet;
- Check out the issue tracker to make sure someone already hasn't requested it
and/or contributed it;
- Fork the project;
- Start a feature/bugfix branch;
- Commit and push until you are happy with your contribution;
- Make sure to add tests for it. This is important so I don't break it in a
future version unintentionally.;
- Please try not to mess with the Rakefile, version, or history. If you want to
have your own version, or is otherwise necessary, that is fine, but please
isolate to its own commit so I can cherry-pick around it.

## License

Please see [LICENSE](https://github.com/Quasar-Flash/brl_auth_ruby/blob/master/LICENSE.txt)
for licensing details.

## Authors

Danilo Carolino, [@danilogco](https://github.com/danilogco) / [@Quasar-Flash](https://github.com/Quasar-Flash)
