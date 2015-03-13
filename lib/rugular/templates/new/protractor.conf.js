require('coffee-script').register();
require('jasmine');

// An example configuration file
exports.config = {
  // The address of a running selenium server.
  seleniumAddress: 'http://localhost:4444/wd/hub',

  // Use jasmine
  frameworks: ['jasmine', 'chai'],

  // Capabilities to be passed to the webdriver instance.
  capabilities: {
    'browserName': 'firefox'
  },

  // Spec patterns are relative to the configuration file location passed
  // to proractor (in this example conf.js).
  // They may include glob patterns.
  specs: ['./e2e/**/*.coffee'],

  baseUrl: 'http://localhost:8080/',

  jasmineOpts: {
    reporter: "spec",
    slow: 3000
  },

  onPrepare: function() {
    global.By = global.by;
  }
};
