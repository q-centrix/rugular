![Build
Status](https://circleci.com/gh/currica/rugular.svg?style=shield&circle-token=:circle-token)

# Rugular

Rugular is a framework to build AngularJS apps; the goal is to
provide a rails-like interface to constructing a UI with Sass, Haml, and
Coffeescript, and generators to create template files.

## Installation

```bash
gem install rugular
```

## Start a new project

```bash
rugular new <project_name>
```

A new Rugular project contains the following folders:

<pre>
├──  .gitignore/
├──  .tmp/
├──  bower_components/
├──  bower.json
├──  Gemfile
├──  node_modules/
├──  package.json
├──  src/
│   ├──  app/
│   │   ├──  _app.sass
│   │   ├──  app.module.coffee
│   │   ├──  app.config.coffee
│   │   ├──  app.controller.coffee
│   │   ├──  app.controller.spec.coffee
│   │   ├──  app.routes.coffee
│   │   ├──  index.haml
│   ├──  components/
│   ├──  favico.ico
│   ├──  images/
├──  vendor/
</pre>

| Folder/File Name | Description |
| --- | --- |
| .gitignore | Many of the files and folders here are not needed for source control, when deploying an application, please use the ``rugular build`` command described below |
| .tmp | A temporary folder used for storing compiled Haml, Sass, and Coffeescript files. |
| bower_components | A folder used by bower to install packages. |
| bower.json | A list of packages to be installed by bower |
| Gemfile | A way to install the ``rugular`` gem locally. This is not needed if you install ``rugular`` globally |
| node_modules | A folder used by npm to install packages. |
| package.json | A list of packages to be installed by npm |
| src | A folder containing the source code unique to a rugular application.  Rugular apps are written in Haml, Coffeescript and Sass and designed to follow [Google's Best Practices for an Angular App Structure](https://docs.google.com/document/d/1XXMvReO8-Awi1EZXAXS4PzDzdNvV6pGcuaF4Q9821Es/pub).  |
| vendor | 3rd-party javascript, coffeescript, css, and sass files that do not come with bower management. All of these files are included before any code in src. |

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

## Running the Test Suite

To run the test suite just once (such as in a continuous environment) execute:

```bash
rugular ci
```

## Building the app

To build a minified version of your app in the ``/dist`` folder execute:

```bash
rugular build
```

This will create the following files:

* index.html
* application.css (a minified version of the sass files in the src folder)
* vendor.css (a minified version of bower_component and vendor files)
* application.js (a minified version of the coffee files in the src folder)
* vendor.js (a minified version of bower_component and vendor files)

## Contributing

1. Fork it ( https://github.com/currica/rugular/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
Copyright 2014-2015. Q-Centrix. MIT License.
