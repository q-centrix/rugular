var yaml = require('js-yaml')
var fs   = require('fs')
var _    = require('lodash')

module.exports = function (config) {
  loadBowerComponentYamlAndSrcFiles = function() {
    this.bowerComponentFile = fs.readFileSync(
      'bower_components.yaml',
      'utf8',
      function (err, data) {
        console.log(data)
        console.log(err)
        return data
      });
    this.yaml = yaml.load(this.bowerComponentFile)

    this.javascriptFiles = this.yaml.js.concat(this.yaml.test)

    this.addBowerComponentDirectory = function (javascriptFile) {
      return './bower_components/' + javascriptFile;
    };

    this.bowerComponentFiles = _.map(
      javascriptFiles,
      addBowerComponentDirectory
    );

    this.applicationFiles = [
      'src/**/*.module.coffee',
      'src/**/*.routes.coffee',
      'src/**/*.factory.coffee',
      'src/**/*.controller.coffee',
      'src/**/*.directive.coffee',
      'src/**/*.spec.coffee'
    ]

    this.karmaFiles = this.bowerComponentFiles.concat(this.applicationFiles)

    return this.karmaFiles
  }

  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: './',

    frameworks: ['jasmine', 'sinon'],

    preprocessors: {
      '**/*.coffee': ['coffee']
    },

    coffeePreprocessor: {
      // options passed to the coffee compiler
      options: {
        bare: true,
        sourceMap: false
      },
      // transforming the filenames
      transformPath: function(path) {
        return path.replace(/\.coffee$/, '.js');
      }
    },

    // list of files / patterns to load in the browser
    files: loadBowerComponentYamlAndSrcFiles(),

    // web server port
    port: 9876,

    // enable / disable colors in the output (reporters and logs)
    colors: true,

    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR ||
    // config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,

    // watch file and execute tests whenever any file changes
    autoWatch: true,

    // other available browsers: ['Chrome', 'Firefox', 'Safari', 'PhantomJS'],
    browsers: ['PhantomJS'],

    // if true, Karma captures browsers, runs the tests and exits
    singleRun: false
  });
};
