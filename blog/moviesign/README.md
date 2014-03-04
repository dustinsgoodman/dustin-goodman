## moviesign

- [Useful Resources](#useful-resources)
- [Requirements](#requirements)
- [Setup](#setup)
- [Project scaffold](#project-scaffold)
- [Running the project](#running-the-project)
- [Building on the Frontend](#building-on-the-frontend)
  - [Create a new page](#create-a-new-page)
  - [Create a new controller](#create-a-new-controller)
  - [Create a new directive](#create-a-new-directive)
  - [Create a new service](#create-a-new-service)

### Useful Resources
- [John Lindquist's Angular Tutorials](https://egghead.io/lessons) (Best Resource)
- [Everything you need to understand to start with AngularJS](http://stephanebegaudeau.tumblr.com/post/48776908163/everything-you-need-to-understand-to-start-with)
- [Restangular Docs](https://github.com/mgonto/restangular)
- [ng-grid](http://angular-ui.github.io/ng-grid/)
- [ngInfiniteScroll](http://binarymuse.github.io/ngInfiniteScroll/)

### Requirements
* node.js v0.10.* (latest stable)
* npm

### Setup
To install node.js:
```bash
brew update
brew install node
```

To install npm:
```bash
# Options 1 (recommended):
curl https://npmjs.org/install.sh | sh

# Options 2:
git clone http://github.com/isaacs/npm.git
cd npm
sudo make install
```

Install required npm packages (remove -g if you do not want the package globally):
```bash
npm install -g yo
npm install -g generator-angular
```

Once the npm packages are installed, install project depedences:
```
cd path/to/tom-servo/moviesign
npm install
bower install
```

### Running the project
There are a few options via grunt to use the angular project.
```bash
# runs server on port 9000
grunt server

# runs unit tests
grunt test

# runs unit tests then the server on port 9000 if tests pass
grunt

# builds project for deployment into dist folder in project root
grunt build
```

### Building on the Frontend
You can use [yeoman to generate/scaffold](https://github.com/yeoman/generator-angular) out new frontend components and features. It is recommended to use this method because it also generates the unit test files with skeleton code.

#### Create a new page
When making a new page/route, you should use the following command in the terminal:
```bash
yo angular:route <myroute> --minsafe
```

This will generate a new controller and view with `myroute`'s value. It will also include the new route in `moviesign/app/scripts/app.coffee`. Before continuing to create the controller and view, please make sure to set the permissions for the new route by adding an `access` key to the route configuration. All available permission levels can be found in `moviesign/app/scripts/settings/permissions.coffee`.

The controller will be in `moviesign/app/scripts/controllers/` and the view will be in `moviesign/app/views/`.

#### Create a new controller
If you need to create a standalone controller, use the following command.

```bash
yo angular:controller <mycontroller> --minsafe
```

Controllers live in `moviesign/app/scripts/controllers/`.

#### Create a new directive
If you need to create a new directive, use the following command.

```bash
yo angular:directive <mydirective> --minsafe
```

Directives live in `moviesign/app/scripts/directives/`.

#### Create a new service
If you need to make a new service, use the following command.

```bash
yo angular:factory <myfactory> --minsafe
```

Services live in `moviesign/app/scripts/services/`.
