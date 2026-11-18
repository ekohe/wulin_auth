# AGENTS.md

`wulin_auth` is a Rails engine, never run standalone. It adds email and password login to a host app and is meant to run alongside [`wulin_master`](https://github.com/ekohe/wulin_master). mima loads it as the submodule `vendor/gems/wulin_auth` and subclasses `WulinAuth::User`. ekohe-backoffice also uses it. This file is for agents working in a host app that consumes this gem. To develop the gem itself, see the README's Development section.

## Wiring it into a host app

- Gemfile, `db:migrate`, `config.action_mailer.default_url_options` and `WulinAuth.setup` are in the README's Installation section.
- The engine draws its routes into `Rails.application.routes` (`config/routes.rb`), so the engine is never mounted. The routes are `/login`, `/logout`, `/password_resets`, `/reset_password/:token` and `/setup_password/:token`.
- `lib/application_controller.rb` includes `current_user` into `AbstractController::Base` and `require_login` into `ActionController::Base`. `current_user` reads `session[:user_id]`.
- The layout `wulin_auth` loads the `wulin_auth` JavaScript and stylesheet. The host app must make both available through its own asset pipeline. With Propshaft the engine adds no precompile entries.

## Gotchas

- The engine copies its migrations only when the host app root is not the engine root (`append_migrations` in `lib/wulin_auth/engine.rb`). The migrations skip creating `users` or its unique email index when they already exist.
- Users whose email domain is in `APP_CONFIG[Rails.env]["provider_domain"]["microsoft"]` cannot sign in with a password or reset it. Without `APP_CONFIG` the list is empty and an error is logged. The "Sign in with Office 365" button shows only when `APP_CONFIG["OFFICE365_KEY"]` is set.
- `WulinAuth::User` always validates a password. `send_password_reset!` saves with `validate: false` so a user without a password can still get a reset token.

## Commands

- `bundle exec rspec` runs the suite against `spec/dummy`. It needs PostgreSQL and `spec/dummy/config/database.yml` (gitignored; copy `database.example.yml` and set `username`).
- `gem build wulin_auth.gemspec` builds the gem, as the CI `build` job does.
