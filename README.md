dustin-goodman
==============

A personal site that uses Angular.js to create a single page application with a Ruby on Rails 4 backend.

## Requirements
* Ruby 2.0.0p353 (managed via [rbenv][3])
* Rails 4.0.1
* node.js v0.10.22
* [npm][5] 1.3.15
* [yeoman][4] 1.0.x

## Setup Instructions
Preparing the rails app:
 1. `cd /path/to/app && bundle install`
 2. configure a MySQL server and include in `config/database.yml`
Preparing the angular app:
 1. `cd /path/to/app/public/angular && npm install`
 2. `cd /path/to/app/public/angular/app && bower install`

## App Configuration
* Followed [Rocky Jaiswal][1]'s blog article to configure Rails and Angular to work in harmony.
* Followed [Daniel Morrison][2]'s articles to create an elegant Rails backend API.

 [1]: http://rockyj.in/2013/10/24/angular_rails.html
 [2]: http://collectiveidea.com/blog/archives/2013/06/13/building-awesome-rails-apis-part-1/
 [3]: https://github.com/sstephenson/rbenv
 [4]: http://yeoman.io
 [5]: https://npmjs.org