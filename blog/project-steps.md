Starting the project:

In terminal:
```bash
gem install rails-api
rbenv rehash
rails-api new <api-name> -S -T
```

-S skips sprockets, Grunt solves this problem
-T skips tests, I will use RSpec

```bash
cd public/app
bower install restangular --save
bower install underscore --save
bower install bootstrap --save
```