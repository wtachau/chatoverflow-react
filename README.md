# chat-overflow-react
Front end React components for chatoverflow

## Installation

Install local npm modules

```npm install```

And start the dev server

```npm run devserve```

*If that script fails because node can't find webpack-dev-serve*:

Make sure `webpack-dev-server` is installed globally

```npm install webpack-dev-server -g```


### Note: 
The `devserve` script doesn't handle the router properly, so if you try to reload something like `domain.com/path/subpath`, it will throw an error. If you need to use the routes, run the `npm run testRoutes` script. This script builds the `bundle.js` then starts a simple express server, so it will handle the routes, but you'll need to re-run the script to for file changes to register.


## Deploying

Install the `aws-cli` tool (amazon web services command line interface)

``` pip install awscli```

Configure your shell to use the `chatoverflow` s3 bucket by following [these steps](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html). You'll need the aws key and secret key from [here](https://drive.google.com/open?id=0BxI3aj0CvwjudDJITEx6LUJxNVE). The region is `us-east-1`.

Then deploy:

```npm run pushToStaging```

