# FinePrint

Versioned legal document management for Rails. Track and enforce user acceptance of Terms of Service, Privacy Policy, and other legal agreements with versioned documents and audit trails.

## Installation

Add to your Gemfile:

```ruby
gem "fine_print"
```

Then run:

```bash
bundle install
rails fine_print:install:migrations
rails db:migrate
```

## Setup

### 1. Configure agreements

Create `config/initializers/fine_print.rb`:

```ruby
FinePrint.configure do |config|
  config.agreements = [
    FinePrint::Agreement.new(
      id: :terms_of_service,
      title: "Terms Of Service",
      version_column: :accepted_terms_of_service_version_id,
      document_type: :terms_of_service,
      prompt_when_updated: true
    ),
    FinePrint::Agreement.new(
      id: :privacy_policy,
      title: "Privacy Policy",
      version_column: :accepted_privacy_policy_version_id,
      document_type: :privacy_policy,
      prompt_when_updated: true
    )
  ]
end
```

### 2. Include concerns

```ruby
# app/models/user.rb
class User < ApplicationRecord
  include FinePrint::Signable
end

# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
  include FinePrint::Enforceable
end
```

### 3. Mount routes

```ruby
# config/routes.rb
mount FinePrint::Engine, at: "/"
```

### 4. Seed initial documents

```bash
rails fine_print:seed
```

## Auth Configuration

FinePrint defaults to Devise conventions. Override for other auth systems:

```ruby
FinePrint.configure do |config|
  config.current_user_method = ->(c) { c.current_user }
  config.signed_in_method = ->(c) { c.user_signed_in? }
  config.auth_controller_method = ->(c) { c.devise_controller? }
  config.sign_out_method = ->(c) { c.sign_out(c.current_user) }
end
```

## Routes

The engine provides:

- `GET /agreements/:id` - Show agreement for acceptance
- `PATCH /agreements/:id` - Accept agreement
- `DELETE /agreements/:id` - Decline agreement (signs user out)
- `GET /terms` - Public terms of service page
- `GET /privacy` - Public privacy policy page
- `GET /admin/documents` - Admin CRUD for managing document versions

## Development

```bash
bundle install
bundle exec rake test
```
