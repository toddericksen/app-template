## Getting Started

This is a Rails template, so you pass it in as an option when creating a new app.

Here's what it includes:
User and Customer models
Scaffold Templates
Error pages
HTML template for emails

Devise for users
SolidCache
SolidQueue + Mission Control

Select Gems

# Rails enhancements and extensions

add_gem 'bootsnap', require: false # Bootsnap: Reduces boot times by caching
add_gem 'jbuilder' # JBuilder: Create JSON structures via a Builder-style DSL
add_gem 'sitemap_generator', '~> 6.1' # SitemapGenerator: Generate sitemaps
add_gem 'thruster', github: 'basecamp/thruster' # Thruster: Accelerating Rails

# Hotwire for modern web apps

add_gem 'stimulus-rails' # Stimulus-Rails: Modest JavaScript framework from Hotwire
add_gem 'turbo-rails' # Turbo-Rails: SPA-like page acceleration from Hotwire

# CSS and JavaScript

add_gem 'cssbundling-rails' # CssBundling-Rails: CSS bundling for Rails
add_gem 'jsbundling-rails' # JsBundling-Rails: JavaScript bundling for Rails

# add_gem 'tailwindcss-rails', '~> 2.3' # TailwindCSS-Rails: Tailwind CSS for Rails

# Utilities for building UI

add_gem 'gravatar_image_tag' # GravatarImageTag: Generate Gravatar image tags
add_gem 'name_of_person', github: 'basecamp/name_of_person' # NameOfPerson: Full name parsing

# add_gem 'madmin' # Madmin: Modern and responsive admin framework

# add_gem 'activestorage-office-previewer' # ActiveStorageOfficePreviewer: Preview Office documents

# Background jobs, caching, and file uploads

add_gem 'image_processing', '~> 1.2' # Image Processing: Library for processing images
add_gem 'mini_magick' # MiniMagick: Ruby wrapper for ImageMagick
add_gem 'mission_control-jobs' # UI for Solid Chache jobs
add_gem 'solid_cache' # SolidCache: Straightforward caching library
add_gem 'solid_queue' # SolidQueue: Simple, solid background job processing library

# Authentication and authorization

add_gem 'devise', '~> 4.9' # Devise: Flexible authentication solution
add_gem 'omniauth-google', '~> 1.0' # OmniAuth-Google: OmniAuth strategy for Google
add_gem 'pretender', '~> 0.3.4' # Pretender: Allows users to impersonate other users
add_gem 'pundit', '~> 2.1' # Pundit: Minimal authorization through OO design

# add_gem 'acts_as_tenant' # ActsAsTenant: Adds multi-tenancy support

# add_gem 'omniauth-facebook', '~> 8.0' # OmniAuth-Facebook: OmniAuth strategy for Facebook

# API and controller utilities

add_gem 'faraday', '~> 2.0' # Faraday: An HTTP client library
add_gem 'friendly_id', '~> 5.4' # FriendlyId: Use text-based ids for models
add_gem 'pagy' # Pagy: A pagination gem
add_gem 'pg_search' # PgSearch: Provides full-text search using PostgreSQL's search capabilities
add_gem 'rack-attack' # Rack-Attack: Middleware for blocking & throttling abusive requests
add_gem 'responders', github: 'heartcombo/responders', branch: 'main' # Responders: Set of Rails responders

# add_gem 'shortener', git: 'https://github.com/jpmcgrath/shortener' # Shortener: Creating shortened URLs

# add_gem 'rqrcode' # Generate QR Codes https://github.com/whomwah/rqrcode

# Monitoring and exception handling

# add_gem 'honeybadger' # Honeybadger: Monitoring and tracking exceptions

# Time based utilities

add_gem 'tzinfo-data', platforms: %i[mswin mswin64 mingw x64_mingw jruby] # TZInfo-Data: Provides timezone data for Windows
add_gem 'whenever' # Whenever: Clear syntax for writing and deploying cron jobs
add_gem 'local_time' # LocalTime: Makes it easy to work with time zones

# add_gem 'simple_calendar' # simple_calendar: Ruby add_gem for generating calendars

# add_gem 'worldwide' # internationalizes and localizes Ruby code. Helps inputting, validating, and formatting mailing addresses

# Notification utilities

add_gem 'letter_opener', group: :development # LetterOpener: Preview email in the browser
add_gem 'noticed', '~> 2.0' # Noticed: Notifications framework for Ruby on Rails

# add_gem 'faker', group: :development # Generate fake data

#### Requirements

You'll need the following installed to run the template successfully:

- Ruby 2.5 or higher
- bundler - `gem install bundler`
- rails - `gem install rails`
- Database - we recommend Postgres, but you can use MySQL, SQLite3, etc
- ImageMagick or libvips for ActiveStorage variants
- Yarn - `brew install yarn` or [Install Yarn](https://yarnpkg.com/en/docs/install)
- Foreman (optional) - `gem install foreman` - helps run all your processes in development

#### Creating a new app

```bash
rails new [name] -d postgresql  -a propshaft -j esbuild -m https://raw.githubusercontent.com/toddericksen/app-template/master/template.rb

```

Or if you have downloaded this repo, you can reference template.rb locally:

```bash
rails new [name] -d postgresql  -a propshaft -j esbuild -m ./app-template/template.rb
```

#### Running your app

```bash
bin/dev
```

You can also run them in separate terminals manually if you prefer.

A separate `Procfile` is generated for deploying to production on Heroku.

#### Authenticate with social networks

We use the encrypted Rails Credentials for app_id and app_secrets when it comes to omniauth authentication. Edit them as so:

```
EDITOR=vim rails credentials:edit
```

Make sure your file follow this structure:

```yml
secret_key_base: [your-key]
development:
  github:
    app_id: something
    app_secret: something
    options:
      scope: "user:email"
      whatever: true
production:
  github:
    app_id: something
    app_secret: something
    options:
      scope: "user:email"
      whatever: true
```

With the environment, the service and the app_id/app_secret. If this is done correctly, you should see login links
for the services you have added to the encrypted credentials using `EDITOR=vim rails credentials:edit`
