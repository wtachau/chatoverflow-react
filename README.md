# chat-overflow-react
Front end React components for chatoverflow

## Installation

Install local npm modules

```npm install```

Make sure `webpack-dev-server` is installed globally
```npm install webpack-dev-server -g```


## Deploying

Install the `aws-cli` tool (amazon web services command line interface)

``` pip install awscli```

Configure your shell to use the `chatoverflow` s3 bucket by following [these steps](http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html). You'll need the aws credentials, which you can get [here](https://drive.google.com/open?id=0BxI3aj0CvwjudDJITEx6LUJxNVE).

Then deploy:

```npm run pushToStaging```

