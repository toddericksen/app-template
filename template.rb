require 'fileutils'
require 'shellwords'

# Copied from: https://github.com/mattbrictson/rails-template
# Add this template directory to source_paths so that Thor actions like
# copy_file and template resolve against our source files. If this file was
# invoked remotely via HTTP, that means the files are not present locally.
# In that case, use `git clone` to download them to a local temporary dir.

# Steps
# rails new [name] -d postgresql  -a propshaft -j esbuild -m ./template-master/template.rb

# NEXT
# add users
#   devise with config (can they self register, etc)
#   bootstrap the first admin user
#   add roles config (default as user, admin)
# protect mission jobs
# add notifications
# add kamal for deploy
# add companies
#   + billing?
#   + locations?
#   + seed the db?
# email unsubscribe

# THEN other basics
# add github actions (done?)

# TODO
# implement company logo lookup
# https://logo.clearbit.com/avistaseniorliving.com
# https://autocomplete.clearbit.com/v1/companies/suggest?query=beehivehomes
# Rite ec4d10a053a20a5d45f0391b24ce9f1ce4d09a62d584
# https://ritekit.com/developer/dashboard/
# https://documenter.getpostman.com/view/2010712/SzS7Qku5?version=latest#de61d96d-a8d1-43d1-8084-2d31407062e7
# https://web.postman.co/workspace/My-Workspace~b6dea295-a621-4864-8c1d-7eb8a2ab2261/request/12307258-b090fc0f-8bf2-4df4-b803-d10d5b1220b4
# https://brandfetch.com/developers/pricing

# step by step signup form
# cookie notice
# billing stuff
# bundle exec honeybadger install hbp_P41e42L5y5pwdIgCleyUJO14jT8HTl23FJ8K

def add_template_repository_to_source_path
  if __FILE__ =~ %r{\Ahttps?://}
    require 'tmpdir'
    source_paths.unshift(tempdir = Dir.mktmpdir('app-template-'))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      '--quiet',
      'https://github.com/toddericksen/app-template.git',
      tempdir
    ].map(&:shellescape).join(' ')

    if (branch = __FILE__[%r{app-template/(.+)/template.rb}, 1])
      Dir.chdir(tempdir) { git checkout: branch }
    end
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

def read_gemfile?
  File.open('Gemfile').each_line do |line|
    return true if line.strip.start_with?('rails') && line.include?('6.')
  end
end

def rails_version
  @rails_version ||= Gem::Version.new(Rails::VERSION::STRING) || read_gemfile?
end

def rails_7_or_newer?
  Gem::Requirement.new('>= 7.0.0.alpha').satisfied_by? rails_version
end

unless rails_7_or_newer?
  say "\nThis app template requires Rails 7 or newer. You are using #{rails_version}.", :green
  say "Please remove partially installed template files #{original_app_name} and try again.", :green
  exit 1
end

def add_gems
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
  # add_gem 'worldwide' #  internationalizes and localizes Ruby code. Helps inputting, validating, and formatting mailing addresses

  # Notification utilities
  add_gem 'letter_opener', group: :development # LetterOpener: Preview email in the browser
  add_gem 'noticed', '~> 2.0' # Noticed: Notifications framework for Ruby on Rails

  # add_gem 'faker', group: :development # Generate fake data
end

def set_application_name
  # Add Application Name to Config
  environment 'config.application_name = Rails.application.class.module_parent_name'

  # Announce the user where they can change the application name in the future.
  puts 'You can change application name inside: ./config/application.rb'
end

def add_customers
  generate 'scaffold Customer name domain logo slug:uniq'
  inject_into_file('app/models/customer.rb', "has_many :users, dependent: :nullify\n", before: /^end/)
end

def add_users
  generate 'scaffold User first_name last_name phone job_title announcements_last_read_at:datetime --force'
end

def add_devise_to_users
  route "root to: 'home#index'"
  generate 'devise:install'
  environment "config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }", env: 'development'

  generate :devise, 'User'

  gsub_file 'config/initializers/devise.rb', /  # config.secret_key = .+/,
            '  config.secret_key = Rails.application.credentials.secret_key_base'

  inject_into_file('app/models/user.rb', 'omniauthable, :', after: 'devise :')
end

def add_authorization
  generate 'pundit:install'
end

def default_to_esbuild
  return if options[:javascript] == 'esbuild'

  return if options[:skip_javascript]

  @options = options.merge(javascript: 'esbuild')
end

def add_javascript
  run 'yarn add local-time esbuild-rails trix @hotwired/stimulus tailwindcss-stimulus-components @hotwired/turbo-rails @rails/activestorage @rails/ujs @rails/request.js chokidar tom-select flatpickr stimulus-flatpickr'
end

def copy_templates
  remove_file 'app/assets/stylesheets/application.css'
  remove_file 'app/javascript/application.js'
  remove_file 'app/javascript/controllers/index.js'
  remove_file 'public/404.html'
  remove_file 'public/422.html'
  remove_file 'public/500.html'
  remove_file 'Procfile.dev'

  copy_file 'Procfile'
  copy_file 'Procfile.dev'
  copy_file '.foreman'
  copy_file 'esbuild.config.mjs'
  copy_file 'app/javascript/application.js'
  copy_file 'app/javascript/controllers/index.js'
  # copy_file 'db/seeds.rb', force: true

  directory 'app', force: true
  directory 'config', force: true
  directory 'lib', force: true
  directory 'public', force: true

  route "get '/terms', to: 'home#terms'"
  route "get '/privacy', to: 'home#privacy'"

  route "get '/500', to: 'errors#internal_server'"
  route "get '/404', to: 'errors#not_found'"
  route "get '/406', to: 'errors#unacceptable'"
  route "get '/401', to: 'errors#unauthorized'"
  route "get '/422', to: 'errors#unprocessable'"
end

def add_solid_cache
  rails_command 'solid_cache:install:migrations'
end

def add_solid_queue
  generate 'solid_queue:install'
  environment 'config.active_job.queue_adapter = :solid_queue'

  insert_into_file 'config/routes.rb',
                   'mount MissionControl::Jobs::Engine, at: "/jobs"',
                   after: 'Rails.application.routes.draw do \n'
end

def add_custom_error_pages
  environment 'config.exceptions_app = routes'
end

def add_i18n
  I18n.available_locales = Worldwide::Locales.top_25
  Worldwide::Config.configure_i18n
end

def add_announcements
  generate 'model Announcement published_at:datetime announcement_type name description:text'
  route 'resources :announcements, only: [:index]'
end

def add_notifications
  rails_command 'noticed:install:migrations'
  route 'resources :notifications, only: [:index]'
end

def add_multiple_authentication
  insert_into_file 'config/routes.rb', ', controllers: { omniauth_callbacks: "users/omniauth_callbacks" }',
                   after: '  devise_for :users'

  generate 'model Service user:references provider uid access_token access_token_secret refresh_token expires_at:datetime auth:text'

  template = ''"
  env_creds = Rails.application.credentials[Rails.env.to_sym] || {}
  %i{ facebook google }.each do |provider|
    if options = env_creds[provider]
      config.omniauth provider, options[:app_id], options[:app_secret], options.fetch(:options, {})
    end
  end
  "''.strip

  insert_into_file 'config/initializers/devise.rb', '  ' + template + "\n\n", before: '  # ==> Warden configuration'
end

def add_whenever
  run 'wheneverize .'
end

def add_friendly_id
  generate 'friendly_id'
  insert_into_file(Dir['db/migrate/**/*friendly_id_slugs.rb'].first, '[5.2]', after: 'ActiveRecord::Migration')
end

def add_actiontext
  rails_command 'action_text:install'
end

def add_sitemap
  rails_command 'sitemap:install'
end

def add_tailwind
  run 'npm install tailwindcss@next @tailwindcss/cli@next'
  insert_into_file 'app/assets/stylesheets/application.css',
                   '@import "app/assets/stylesheets/template/tailwind-theme.css";'
end

def add_esbuild_script
  build_script = 'node esbuild.config.mjs'

  case `npx -v`.to_f
  when 7.1...8.0
    run %(npm set-script build "#{build_script}")
    run %(yarn build)
  when (8.0..)
    run %(npm pkg set scripts.build="#{build_script}")
    run %(yarn build)
  else
    say %(Add "scripts": { "build": "#{build_script}" } to your package.json), :green
  end
end

def add_github_actions_ci
  copy_file 'github/workflows/verify.yml', '.github/workflows/verify.yml'
end

def add_gem(name, *options)
  gem(name, *options) unless gem_exists?(name)
end

def gem_exists?(name)
  IO.read('Gemfile') =~ /^\s*gem ['"]#{name}['"]/
end

# Main setup
add_template_repository_to_source_path
default_to_esbuild
add_gems

after_bundle do
  set_application_name
  copy_templates
  # add_customers
  add_users
  add_devise_to_users
  add_authorization
  add_javascript
  add_announcements
  add_notifications
  add_multiple_authentication
  add_solid_queue
  add_solid_cache
  add_friendly_id
  add_tailwind
  add_whenever
  add_sitemap
  add_github_actions_ci
  rails_command 'active_storage:install'
  # rails_command 'action_text:install'
  # remove_file 'app/assets/stylesheets/action_text.css'

  # Make sure Linux is in the Gemfile.lock for deploying
  run 'bundle lock --add-platform x86_64-linux'

  add_esbuild_script

  # Commit everything to git
  unless ENV['SKIP_GIT']
    git :init
    git add: '.'
    # git commit will fail if user.email is not configured
    begin
      git commit: %( -m 'Initial commit' )
    rescue StandardError => e
      puts e.message
    end
  end

  # Dir.chdir original_app_name

  # rails_command 'db:create db:migrate db:seed'

  say
  say 'Your app was successfully created!', :green
  say 'Follow these steps to get started with your new app:', :blue
  say '  Update config/database.yml with your database credentials'
  say ''
  say "  cd #{original_app_name}"
  say '  rails db:create db:migrate'
  say '  gem install foreman'
  say '  bin/dev'
end
