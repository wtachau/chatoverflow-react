ChatOverflow - React frontend
=============================
[![Circle CI](https://circleci.com/gh/Originate/chat-overflow-rails/tree/develop.svg?style=svg&circle-token=c2656a4a66ee9cbb0d5e8be0bf7ee5451cf2b0ca)](https://circleci.com/gh/Originate/chat-overflow-rails/tree/develop)

This repository includes the entire frontend component to ChatOverflow, written using React. It is meant to be used in conjunction with the [Rails API](https://github.com/originate/chat-overflow-rails) and the [Node socket service](https://github.com/originate/chat-overflow-node).

Note that the other services, when run locally, expect the frontend to be served on port 8080.

The codebase is primarily written in CoffeeScript, including wrappers for creating React elements. The entire project (including its dependencies) is bundled before runtime by webpack, which serves up a single `bundle.js` file.

Stack
------------
- [React](http://facebook.github.io/react/)
- [Coffeescript](http://coffeescript.org/)
- [SCSS] (http://sass-lang.com/documentation/file.SCSS_FOR_SASS_USERS.html)
- [Webpack](http://webpack.github.io/docs/) for bundling


Installation
------------

1. Install local npm modules

 ```npm install```

2. And start the dev server

 ```npm run devserve```

  * If that script fails because node can't find webpack-dev-serve*:

  Make sure `webpack-dev-server` is installed globally

   ```npm install webpack-dev-server -g```


#### Note: 
The `devserve` script doesn't handle the router properly, so if you try to reload something like `domain.com/path/subpath`, it will throw an error. If you need to use the routes, run the `npm run testRoutes` script. This script builds the `bundle.js` then starts a simple express server, so it will handle the routes, but you'll need to re-run the script to for file changes to register.


Deploying
---------

1. Install the `aws-cli` tool (amazon web services command line interface)

 ``` pip install awscli```

2. Configure your shell to use the `chatoverflow` s3 bucket by following [these steps](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html). You'll need the aws key and secret key from [here](https://drive.google.com/open?id=0BxI3aj0CvwjudDJITEx6LUJxNVE). 
  * `awscli` will prompt you for the region, which is `us-east-1`.

3. Then deploy:

 ```npm run pushToStaging```

