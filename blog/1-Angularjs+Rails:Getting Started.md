# Angular.js + Rails: Getting Started

I discovered Angular.js in June 2013 while trying to develop a better solution for a backend tool I had created at work. I fell in love with the framework very shortly after using it to do some simple data binding to the DOM that had previously existed as ~500 lines of messy jQuery. It consolated these awefully written jQuery functions into ~40 lines of concise data binding that were easily extracted into a JSON object and sent to my Rails API using just one clean and simple line of code. 

Recently, I've begun building a large single page application (SPA for short) for work. This time my experience varied greatly as I had to discover lots of Angular's other features that weren't always so easy to use or figure out. This website is actually built using Rails and Angular.js, and this blog is dedicated to explaining how it was built and some choices I made along the way to improve the experience.

## Disclaimers
At this point, you're probably ready to get started. A few disclaimers first:

 1. I'm highly opinionated, so if you feel like I'm being too generous or harsh towards a certain method, I probably am. Please feel free to argue or debate the subject with me down in the comments section.
 2. I'm assuming you understand Ruby on Rails and JavaScript. If you don't, I recommend going to learn these first.
 3. I built this website on OSX so all my recommendations and instructions reflect this as well. If you're on Windows, install Linux. If you're on Linux, I'll most likely revise these instructions to help you later down the line.


## Requirements
First, we need to prepare your system. I'm using Ruby 2.0.0p353 and Rails 4.0.1. Go ahead and use the Rails setup of your choice using the Ruby manager of your choice. I personally recommend [rbenv][1] over [rvm][2], again personal preference. Next, I highly recommend using [yeoman][3] for managing your angular project because it helps manage your project dependencies, provides an awesome testing suite with karma, and gives a nice livereload server for testing your JavaScripts. This will require that you install node.js + npm. I'm using node v0.10.22, npm 1.3.15, and yeoman 1.0.x and below is my recommended method for installing everything including the yeoman angular generator:

```
# use homebrew to install node
>> brew install node
# use curl to install npm
>> curl https://npmjs.org/install.sh | sh
# use npm to install yeomman and angular generator
>> npm install -g yo
>> npm install -g generator-angular
```

## Let's Kickoff the Project
First, you'll need a Rails app. Here's the command a reminder:

  ```rails new <app-name>```

Next, go into your app's public directory and remove all its content (don't worry, your angular app will replace all of it). Now, run the yeoman scaffolding tool for angular:

  ```yo angular --coffee --minsafe```

I run my scaffold with the `--coffee` tag because I personally prefer coffeescript to JavaScript. The node.js community will probably shun me for this, but I really do find it to be a much cleaner language for frontend, and it plays nicely with both angular and Underscore.js (another library I'll be using). The `--minsafe` tag is to prep all my angular files for minifcation. I'll explain more about what this does later when we get into some angular code. Now, we can run our Rails server using the `rails s` command in the project root directory and a `grunt serve`r in the angular app root directory to get both our apps up and running.


## Issues/Gotchas
At this point, we now have a Rails app and an angular app that work perfectly fine individually. However, we want angular to send all API requests in a RESTful manner to Rails especially when in production. Here are the problems:

  1. Rails will run its server on port 3000 and grunt will run its server on port 9000. This will cause a [cross-origin resource sharing (CORS)][4] issue which we can fix with some handy dandy middleware.
  2. To make our api calls work with this setup, we would have to hardcode our links to `localhost:3000`, but we won't have grunt running in production. Luckily, grunt has a nice proxy package we can use to fix this issue so no hardcoding urls for us.

## Frontend Setup
First, let's address the second issue with the needed grunt proxy. We're going to install [`grunt-connect-proxy`][5] before we configure it. Go to your terminal and from your angular project root, run:

  ```npm install grunt-connect-proxy --save-dev```

This will use npm to install the `grunt-connect-proxy` and then add it to your `package.json` file found in your project root. I'll explain this more in a yeoman tutorial (will add link later). Next, you need to configure grunt accordingly. You can find all the instructions on the [Github page for grunt-connect-proxy][5], but I'll reiterate them here based on what we're doing. Open up `Gruntfile.js` and add the following:

```javascript
# add this near your other loadNpmTaks
grunt.loadNpmTasks('grunt-connect-proxy');

# In your initConfig connect task, add another key-value 
# pair called proxies. It should look like the following:
grunt.initConfig({
  connect: {
    options: {
      port: 9000,
      hostname: 'localhost'
    },
    proxies: [{
      context: '/api',
      host: '0.0.0.0',
      port: 3000,
      https: false,
      changeOrigin: false,
      xforward: false
    }]
  }
})

# add the proxy middleware
var proxySnippet = require('grunt-connect-proxy/lib/utils').proxyRequest;

# add the middleware call in the connect option middleware hook
connect: {
  livereload: {
    options: {
      middleware: function (connect, options) {
        var middlewares = [];
        var directory = options.directory || options.base[options.base.length - 1];
        if (!Array.isArray(options.base)) {
          options.base = [options.base];
        }
        options.base.forEach(function(base) {
          // Serve static files.
          middlewares.push(connect.static(base));
        });

        // Setup the proxy
        middlewares.push(require('grunt-connect-proxy/lib/utils').proxyRequest);

        // Make directory browse-able.
        middlewares.push(connect.directory(directory));

        return middlewares;
      }
    }
  }
}

# add the configureProxies task before connect in the serve task
grunt.registerTask('serve', function (target) {
  grunt.task.run([
    'clean:server',
    'configureProxies',
    'concurrent:server',
    'autoprefixer',
    'connect:livereload',
    'watch'
  ]);
});
```

[Here][6] is my commit where I configure grunt for the proxy middleware. Depending on your choices, your file may or may not look the same. I personally changed the connection option hostname variable to `'0.0.0.0'` because I like to test my websites on mobile devices. **One more gotcha**: the Gruntfile does not like double quotes (") so make sure you use single quotes (') whenever you make a string.

Now, your frontend is good to go.

## Backend Setup
Now, we need to install and configure the backend middleware to prevent the CORS issue. Fortunately for us, there is a gem to solve this problem called [`rack-cors`][7]. You'll want to add it to your Gemfile in your develpoment group and then configure it in your `config/environments/development.rb`. The configuration should look as follows:

```ruby
config.middleware.use Rack::Cors do
  allow do
    origins 'localhost:9000'
    resource '*', :headers => :any, :methods => [:get, :post, :options, :delete]
  end
end
```

[Here's my commit] where I install the gem and configure it.

## Deployment

We'll cover this in more detail in another post because there are several ways to approach this issue.

## All Engines Go
Now, you're ready to develop your new app using Rails + Angular. Check out my future blog articles on Angular.js features and some other tips and tricks!

  [1]: https://github.com/sstephenson/rbenv
  [2]: https://rvm.io
  [3]: http://yeoman.io
  [4]: http://en.wikipedia.org/wiki/Cross-origin_resource_sharing
  [5]: https://github.com/drewzboto/grunt-connect-proxy
  [6]: https://github.com/sharocko/dustin-goodman/commit/f80d818fe9d7ffd773b984f97476462bcd84b1e4
  [7]: https://github.com/cyu/rack-cors
  [8]: http://github.com/sharocko/dustin-goodman/commit/79d87a85f24d018a72b6f537d7f9efec6d4a62f1