## Getting Started

This is a Rails template, so you pass it in as an option when creating a new app.

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
