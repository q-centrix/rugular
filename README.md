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
├──  .application.sass
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
│   ├──  fonts/
│   ├──  images/
├──  vendor/
</pre>

| Folder/File Name | Description |
| --- | --- |
| .application.sass | A manifest sass file for development purposes |
| .gitignore | Many of the files and folders here are not needed for source control, when deploying an application, please use the ``rugular build`` command described below |
| .tmp | A temporary folder used for storing compiled Haml, Sass, and Coffeescript files. |
| bower_components | A folder used by bower to install packages. |
| bower.json | A list of packages to be installed by bower |
| Gemfile | A way to install the ``rugular`` gem locally. This is not needed if you install ``rugular`` globally |
| node_modules | A folder used by npm to install packages. |
| package.json | A list of packages to be installed by npm |
| src | A folder containing the source code unique to a rugular application.  Rugular apps are written in Haml, Coffeescript and Sass and designed to follow [Google's Best Practices for an Angular App Structure](https://docs.google.com/document/d/1XXMvReO8-Awi1EZXAXS4PzDzdNvV6pGcuaF4Q9821Es/pub).  |
| src/fonts and src/images | Folders to place fonts and images respectively, in a rugular application they are referenced by their relative filename, e.g.  ``src/images/logo.png`` can be linked as ``<img src='logo.png'></img>``
| vendor | 3rd-party javascript, coffeescript, css, and sass files that do not come with bower management. All of these files are included before any code in src. |

### Rugular Generators

Rugular generators assist with developing apps by creating template files in
the src directory. These are influenced by [John Papa's AngularJS Style
Guide](https://github.com/johnpapa/angularjs-styleguide).

Each command will create a folder in the ``src/app`` directory that will
contain the template files and new angular module file if one does not already
exist. It will also register the angular module, by inserting its declaration
in the appropriate spot in your application.

Each command can also contain nesting instructions when you find it appropriate
to nest angular modules. An example of nesting is given below.

#### Create a Route

A route refers to the files necessary to generate a URL route in an angular
application. Rugular utilizes [Angular UI
Router](https://github.com/angular-ui/ui-router) in its template files.

```bash
rugular generate route <route_name>
```

For example, ``rugular generate route dashboard`` generates the following files:

```
src/app/_dashboard.sass
src/app/dashboard.controller.coffee
src/app/dashboard.haml
src/app/dashboard.module.coffee
src/app/dashboard.routes.coffee
```

In your browser, the default ui can be seen by visiting ``/dashboard``

#### Creating a nested route:

```bash
rugular generate route admin:dashboard
```

generates:

```
src/app/admin/_dashboard.sass
src/app/admin/dashboard.controller.coffee
src/app/admin/dashboard.haml
src/app/admin/dashboard.module.coffee
src/app/admin/dashboard.routes.coffee
```

with a new route at ``/admin/dashboard``

#### Create a Directive

A [directive](https://docs.angularjs.org/guide/directive) refers to an
abstracted piece of DOM.

```bash
rugular generate directive <directive_name>
```

#### Create a Factory (TODO)

```bash
rugular generate factory <factory_name>
```

#### Create a Filter (TODO)

```bash
rugular generate filter <factory_name>
```

### Creating a component

A component refers to shareable, abstracted angular modules, that are not
particular to your application. For instance, if you are developing a suite of
separate applications, a common navigation bar may qualify as a component. To
create a component, simply run any generator command with the ``-c`` option and
the service will be created in the ``src/components`` folder.

## Development Server

Rugular includes a built in server that will interpret Coffeescript/Haml/Sass
and run a server on ``localhost:5000``. To run the server, type:

```bash
bundle exec rugular server
```

## Running the tests

### During development

``rugular server`` runs the tests with karma. Karma watches the files in the
``src`` directory and runs the tests on each save.

### Running the tests once

To run these tests just once (perhaps for CI) run:

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
