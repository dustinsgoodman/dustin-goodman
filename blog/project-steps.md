Starting the project:

In terminal:
```bash
$ gem install rails-api
$ rbenv rehash
$ rails-api new <api-name> -S -T
```

-S skips sprockets, Grunt solves this problem
-T skips tests, I will use RSpec

```bash
$ cd public/app
$ bower install restangular --save
$ bower install underscore --save
$ bower install bootstrap --save
```


after adding devise to gemfile:
```bash
$ bundle install
$ rails generate devise:install
      create  config/initializers/devise.rb
      create  config/locales/devise.en.yml
===============================================================================

Some setup you must do manually if you haven't yet:

  1. Ensure you have defined default url options in your environments files. Here 
     is an example of default_url_options appropriate for a development environment 
     in config/environments/development.rb:

       config.action_mailer.default_url_options = { :host => 'localhost:3000' }

     In production, :host should be set to the actual host of your application.

  2. Ensure you have defined root_url to *something* in your config/routes.rb.
     For example:

       root :to => "home#index"

  3. Ensure you have flash messages in app/views/layouts/application.html.erb.
     For example:

       <p class="notice"><%= notice %></p>
       <p class="alert"><%= alert %></p>

  4. If you are deploying on Heroku with Rails 3.2 only, you may want to set:

       config.assets.initialize_on_precompile = false

     On config/application.rb forcing your application to not access the DB
     or load models when precompiling your assets.

  5. You can copy Devise views (for customization) to your app by running:

       rails g devise:views

===============================================================================
$ 
```

do step 1 and ignore the rest because we're using rails-api

```bash
$ rails g devise User
```

update devise handlers for authentication avoid flash messages and redirection (40b1ba55db990cd4ba06ba0770ad958164e80838)
add token based authentication (715030a2e1af41ea1688de71fa0071c6dc78482b)