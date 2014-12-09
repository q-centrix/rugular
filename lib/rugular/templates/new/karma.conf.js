module.exports = function (config) {
  config.set({

    // base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: './',

    frameworks: ['mocha', 'chai', 'sinon', 'chai-sinon'],

    // list of files / patterns to load in the browser
    files: [
      './test/*.js',

      './bower_components/angular/angular.js',
      './bower_components/angular-ui-router/release/angular-ui-router.js',
      './bower_components/angular-mocks/angular-mocks.js',
      './bower_components/angular-bootstrap/ui-bootstrap-tpls.min.js',

      '.tmp/**/*.module.js',
      '.tmp/**/*.routes.js',
      '.tmp/**/*.controller.js',
      '.tmp/**/*.directive.js',
      '.tmp/**/*.spec.js'
    ],

    // web server port
    port: 9876,

    // enable / disable colors in the output (reporters and logs)
    colors: true,

    // level of logging
    // possible values: config.LOG_DISABLE || config.LOG_ERROR ||
    // config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO,

    // enable / disable watching file and executing tests whenever any file changes
    autoWatch: true,

    // start these browsers
    // available browser launchers: https://npmjs.org/browse/keyword/karma-launcher
    // browsers: ['Chrome', 'ChromeCanary', 'FirefoxAurora', 'Safari', 'PhantomJS'],
    browsers: ['PhantomJS'],

    // Continuous Integration mode
    // if true, Karma captures browsers, runs the tests and exits
    singleRun: false
  });
};
