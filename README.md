# WulinAuth

WulinAuth is a Rails engine that adds email and password login, logout and password reset to an app. It works with `wulin_master`: when WulinMaster is loaded, it adds a user menu with a Logout item.

## Installation

Add the submodule at `vendor/gems/wulin_auth` on `develop`, then add the gem to the Gemfile:

```ruby
gem "wulin_auth", path: "vendor/gems/wulin_auth"
```

Run:

```shell
bundle install
bundle exec rails db:migrate
```

The engine appends its migrations to the host app. They create the `users` table.

Set the host for the links in the password reset email in the environment configuration:

```ruby
config.action_mailer.default_url_options = { host: "localhost:3000" }
```

Set the sender of the password reset email:

```ruby
WulinAuth.setup do |config|
  config.password_reset_email_from = "noreply@domain.tld"
end
```

## Usage

The engine adds these routes to the host app: `/login`, `/logout`, `/password_resets`, `/reset_password/:token` and `/setup_password/:token`.

Call `require_login` in a controller to redirect anonymous visitors to `/login`. `current_user` returns the signed-in `WulinAuth::User`. Passwords must reach a zxcvbn score of 2.

## Development

Use Ruby 4.0.9 and Rails 8.1. The specs run against a dummy app in `spec/dummy` that needs PostgreSQL:

```shell
cp spec/dummy/config/database.example.yml spec/dummy/config/database.yml
bundle install
RAILS_ENV=test bundle exec rails db:create db:schema:load
bundle exec rspec
```

## License

MIT, see `LICENSE`.
