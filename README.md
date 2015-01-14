![Build
Status](https://circleci.com/gh/currica/rugular.svg?style=shield&circle-token=:circle-token)

# Rugular

Rugular is a ruby scaffolding framework to build AngularJS apps. It builds a
minified and compressed version of a front-end into the ``./dist`` folder that
can be served as a standalone AngularJS app. The goal of this framework is to
create applications written with [best AngularJS
practices](https://github.com/johnpapa/angularjs-styleguide) using
CoffeeScript, Haml and Sass.

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
│   ├──  application.sass (manifest file)
│   ├──  app/
│   │   ├──  app.module.coffee
│   │   ├──  app.config.coffee
│   │   ├──  app.controller.coffee
│   │   ├──  app.controller.spec.coffee
│   │   ├──  app.routes.coffee
│   │   ├──  index.haml
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

You must have [http-server](https://github.com/nodeapps/http-server) installed.

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

Routes can be nested in another folder representing a module. For example, to
nest a route inside a pre-existing 'test' module, execute:

```bash
rugular generate route test:<route_name>
```

#### Create a Directive

```bash
rugular generate directive <directive_name>
```

This command will create a directive and controller namespaced with a new
module of the feature name if one does not already exist. It will also register
the new module in the ``app.module.js`` file.

Directives can be nested in another folder representing a module like routes.
For example, to nest a directive inside a pre-existing 'test' module, execute:

```bash
rugular generate directive test:<directive_name>
```

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

## Running the Test Suite

To run the test suite just once (such as in a continuous environment) execute:

```bash
rugular ci
```

## Building the app

Rugular builds a minified, compressed version of your app in the ``/dist``
folder. This is done for you by the ``rugular server`` command.

## Contributing

1. Fork it ( https://github.com/currica/rugular/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
Copyright 2014-2015. Q-Centrix. MIT License.
