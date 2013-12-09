dustin-goodman
==============

A personal site that uses Angular.js to create a single page application with a Ruby on Rails 4 backend.

## Requirements
* Ruby 2.0.0p353 (managed via rbenv)
* Rails 4
* node.js v0.10.22
* npm 1.3.15
* Yeoman 1.0.4 (http://yeoman.io)

## Setup Instructions
Preparing the rails app:
 1. `cd /path/to/app && bundle install`
 2. configure a MySQL server and include in config/database.yml
Preparing the angular app:
 1. `cd /path/to/app/public/angular && npm install`
 2. `cd /path/to/app/public/angular/app && bower install`

## App Configuration
Followed [Rocky Jaiswal][1]'s blog article to configure Rails and Angular to work in harmony.

 [1]: http://rockyj.in/2013/10/24/angular_rails.html
