[![Build Status](https://travis-ci.org/currica/rugular.svg)](https://travis-ci.org/currica/rugular)

# Rugular

Rugular is a ruby scaffolding framework to build AngularJS apps. It builds a
minified and compressed version of a front-end into the ``./dist`` folder that
can be served as a standalone AngularJS app. The goal of this framework is to
create applications written with [best AngularJS
practices](https://github.com/johnpapa/angularjs-styleguide); CoffeeScript
optional.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rugular'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rugular

## Start a new project

```bash
rugular new <project_name>
```

This will create the initial project template that follows [Google's Best
Practices for an Angular App
Structure](https://docs.google.com/document/d/1XXMvReO8-Awi1EZXAXS4PzDzdNvV6pGcuaF4Q9821Es/pub).
<pre>
├──  bower_components/
├──  bower.json
├──  Gemfile
├──  package.json
├──  src/
│   ├──  app/
│   │   ├──  app.module.coffee
│   │   ├──  app.config.coffee
│   │   ├──  app.controller.coffee
│   │   ├──  app.controller.spec.coffee
│   │   ├──  app.routes.coffee
│   │   ├──  index.haml
│   │   ├──  index.sass
│   ├──  components/
│   ├──  404.html
│   ├──  500.html
│   ├──  favico.ico
</pre>

## Development Server

Rugular includes a built in server that will interpret Coffeescript/Haml/Sass
and run a server on ``localhost:8080``. To run the server, type:

```bash
bundle exec rugular server
```

## Running the tests

### Unit Tests

Unit tests are included in the development server. To run these tests just once
(perhaps for CI) run:

```
karma start karma.conf.js --single-run
```

### End to End tests

End to end tests with protractor can be run with:

```bash
protractor
```

Please make sure you have mocha installed globally!

### Rugular Generators

#### Create a Route

A route creates a angular route, controller, and view in the app folder.

```bash
rugular generate route <route_name>
```

This command will create a folder in the ``src/app`` directory that will
contain a controller and service namespaced with a new module of the route
name if one dos not already exist. It will also register the new module in the
``app.module.js`` file.

#### Create a Directive

```bash
rugular generate directive <directive_name>
```

This command will create a directive and controller namespaced with a new
module of the feature name if one does not already exist. It will also register
the new module in the ``app.module.js`` file.

#### Create a Factory (TODO)

```bash
rugular generate factory <factory_name>
```

This command will create contain a factory namespaced with a new module of the
feature name if one does not already exist. It will also register the new
module in the ``app.module.js`` file.

### Creating a component

A component refers to shareable, abstracted angular modules. To create a
component, simply run any generator command with the ``-c`` option and the
service will be created in the ``src/components`` folder.


## TODO (need to build)

### Building the app

Rugular builds a minified, compressed version of your app in the ``/dist``
folder. To build the app run:

```
rugular build
```

## Contributing

1. Fork it ( https://github.com/currica/rugular/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
Copyright 2014. Q-Centrix. MIT License.
