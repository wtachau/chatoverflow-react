var config = require('./webpack.config.js');
var webpack = require('webpack');

config.plugins.push(
  new webpack.DefinePlugin({
    "process.env": {
      "NODE_ENV": JSON.stringify("development"),
      "GA_TRACKING_ID": JSON.stringify("UA-65362200-1")
    }
  })
);

module.exports = config;