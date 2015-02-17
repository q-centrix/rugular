![Build
Status](https://circleci.com/gh/currica/rugular.svg?style=shield&circle-token=:circle-token)

# Rugular

Rugular is a framework to build AngularJS 1.3 apps. The goal is to
provide a rails-like interface to constructing a UI with Sass, Haml, and
CoffeeScript with generators to create template files.

> AngularJS is a fast-moving framework, and it is a goal of Rugular to keep
> pace with all the exciting changes that are happening. Please read more about
> the anticipated changes in the [roadmap section](#roadmap) below.

## Installation

### Prerequesites

* nodejs
* bower
* ruby 2.0 or later

### Installing the Gem

```bash
gem install rugular
```

### Install dependencies

Download all necessary dependencies by running the ``rugular dependencies``
task. This will download packages from both ``npm`` and ``bower``.

## Start a new project

```bash
rugular new <project_name>
```

A new Rugular project contains the following folders and files:

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
│   ├──  assets/
│   ├──  components/
│   ├──  favico.ico
├──  vendor/
├──  vendor_and_bower_components.yaml
</pre>

| Folder/File Name | Description |
| --- | --- |
| .application.sass | A manifest sass file for development purposes, you do not need to edit this file. |
| .gitignore | Many of the files and folders here are not needed for source control, when deploying an application, please use the ``rugular build`` command described below |
| .tmp | A temporary folder used for storing compiled Haml, Sass, and Coffeescript file, you do not need to edit any files in this folder. |
| bower_components | A folder used by bower to install packages. |
| bower.json | A list of packages to be installed by bower. |
| Gemfile | A way to install the ``rugular`` gem locally. This is not needed if you install ``rugular`` globally. |
| node_modules | A folder used by npm to install packages. |
| package.json | A list of packages to be installed by npm. |
| src | A folder containing the source code unique to a rugular application. |
| src/app | A folder for application code that correlates to the layout of the application and a URL route in the application. A section is detailed below about [How to Write Rugular apps](#how-to-write-rugular-apps). |
| src/components | A folder for isolate-scope directives to be used in your application code. This folder is also described in [How to Write Rugular apps](#how-to-write-rugular-apps). |
| src/assets | A folder to place assets, including but not limited to, ``.png``, ``.woff``, ``.svg``, ``.pdf``. All files placed in the assets folder can be linked by their relative filename, e.g.  ``src/assets/logo.png`` can be linked as ``<img src='assets/logo.png'></img>``
| vendor | 3rd-party javascript, coffeescript, css, and sass files that do not come with bower management. All of these files are included before any code in src. |
| vendor_and_bower_components.yaml | A file to declare what third party files in the bower_components and vendor folder you would like to include. |

## How to Write Rugular Apps

Application specific code lies in the ``src`` folder. Other files, such as
bower_components or other 3rd party vendor files are declared in the
``vendor_and_bower_components.yaml`` file.

Code in the src folder are written in Coffeescript, Haml and Sass and designed
to follow [Google's Best Practices for an Angular App
Structure](https://docs.google.com/document/d/1XXMvReO8-Awi1EZXAXS4PzDzdNvV6pGcuaF4Q9821Es/pub).
The ``rugular new`` command creates an initial folder setup with an ``src/app``
folder and an ``src/components`` folder.

### The src/app folder

The files in the ``src/app`` folder that have ``app`` are special to a rugular
application.

The ``src/app/app.module.coffee`` declares the base module for the application.
Any modules that are created within one level of nesting in the ``src/app``
folder (e.g. ``src/app/dashboard/dashboard.module.coffee``) are to be included
in the ``app.module.coffee`` declaration.

The ``src/app/app.routes.coffee`` file declares a base route for the
application from which all other routes are derived from. As such, it is
advised to prepend all other routes with ``'root.'``.

Because the ``app.routes.coffee`` file declares a base route, the
``src/app/app.haml`` file serves as an application layout for the rest of your
application. If you have directives such as a ``navbar`` or ``footer``
directive, it is advised to add these directives to this ``haml`` file.

### The src/components folder

The ``src/components`` folder should contain folders of one-off modules that
contain one or more of the following:

* A directive with isolate scope.
* A factory for encapsulating server-side calls.
* A filter for sorting data.

These files can also live in the ``app`` directory. It is recommended to put
abstract modules that can be used in other projects in the ``src/components``
directory.

### Server Side calls

Rugular apps are intended to interface with one main API. The base URL of that
API can be configured in the ``config.yaml`` file for both the ``rugular
server`` command for development, and the ``rugular build`` command for
production. The ``config.yaml`` file contains defaults for ``localhost:3000``
for a local server and a ``RUGULAR_SERVER`` environment variable that can be
injected during a deployment script, e.g. a Dockerfile.

## Rugular Generators

Rugular generators assist with developing apps by creating template files in
the src directory. The generated files are heavily influenced by [John Papa's
AngularJS Style Guide](https://github.com/johnpapa/angularjs-styleguide).

Each command will create a folder in the ``src/app`` directory that will
contain the template files and new angular module file if one does not already
exist. It will also register the angular module, by inserting its declaration
in the appropriate spot in your application.

#### Nesting with Rugular

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
src/app/dashboard.controller.spec.coffee
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
src/app/admin/dashboard.controller.spec.coffee
src/app/admin/dashboard.haml
src/app/admin/dashboard.module.coffee
src/app/admin/dashboard.routes.coffee
```

with a new route at ``/admin/dashboard``

#### Create a Directive

A [directive](https://docs.angularjs.org/guide/directive) refers to an
abstracted DOM element.

```bash
rugular generate directive <directive_name>
```

For example, ``rugular generate directive navbar`` generates:

```
src/app/_navbar.sass
src/app/navbar.controller.coffee
src/app/navbar.controller.spec.coffee
src/app/navbar.directive.coffee
src/app/navbar.haml
src/app/navbar.module.coffee
```

#### Create a Factory

A [factory](https://docs.angularjs.org/guide/services) is an angular service
that encapsulates data pulled in from other sources.

```bash
rugular generate factory <factory_name>
```

For example, ``rugular generate factory questions`` generates:

```
src/app/questions.factory.coffee
src/app/questions.module.coffee
```

#### Create a Filter

A [filter](https://docs.angularjs.org/guide/filter) refers to special
formatters in your app. For example, a filter can encapsulate a sorting
function for displaying an ``ng-repeat``.

```bash
rugular generate filter <factory_name>
```

For example, ``rugular generate filter reverse_alphabetical`` generates:

```
src/app/reverse_alphabetical.filter.coffee
src/app/reverse_alphabetical.filter.spec.coffee
src/app/reverse_alphabetical.module.coffee
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

## Development Tmux

Instead of running the server, rugular has built in support to generate a tmux
session with [Tmuxinator](https://github.com/tmuxinator/tmuxinator) that
includes all the processes on different panes and vim in the first pane. To
start a new tmuxinator session, type:

```bash
bundle exec rugular tmux
```

## Running the tests

### During development

``rugular server`` or ``rugular tmux`` runs the unit tests with karma and the
end-to-end tests with protractor. Karma watches the files in the ``src``
directory and runs the unit tests on each save. Protractor tests are intended
to be run individually, or as a suite in CI.

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


## Roadmap

As soon as it reaches a stable release:

* ``angular-ui-router`` will be replaced by the ``router`` re-write by the
  Angular team.
* Angular 1.3 will be updated to Angular 1.4

Post Angular 2.0 changes

* replace CoffeeScript with EcmaScript6
* replace the folder structure and build scripts to take advantage of
  EcmaScript 6 modules

## Contributing

1. Fork it ( https://github.com/currica/rugular/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
Copyright 2014-2015. [Q-Centrix](http://www.q-centrix.com/). MIT License.
