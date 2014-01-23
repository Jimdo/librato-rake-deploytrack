# Librato Rake Deploytrack
Rake tasks to keep track of your deploys in Librato Metrics, using the annotations streams!

[![Build Status](http://static.squarespace.com/static/5141f98de4b01238136e109c/5141fb8ce4b0253264ed19af/5141fb8fe4b0253264ed1a12/1363278744208/?format=750w)](http://blog.librato.com/posts/2012/09/annotations)

## Installation
Librato Rake Deploytrack is a collection of raketasks. So you should be able to include them in every application utilizing rake.

Add this gem to your `Gemfile`
```ruby
gem 'librato-rake-deploytrack'
```

### Installation (Rails 4.x)

Nothing \o/
Your done. Librato Rake Deploytrack hooks automatically into rake.

### Installation w/o Rails

To use Librato Rake Deploytrack without Rails simply require it in your `Rakefile`

```ruby
require 'librato-rake-deploytrack'
```

## Configuration

All configuration is done via environment variables. There are four thing you can tweak

 * `LIBRATO_USER` - **REQUIRED**
 * `LIBRATO_TOKEN` - **REQUIRED**
 * `LIBRATO_SOURCE` - *this defaults to `production`*
 * `LIBRATO_DEPLOY_FILE` - *this defaults to `librato-rake-deploytrack-deploy-id`* - the file which is used to keep track of your state during the deploy

 `LIBRATO_USER`, `LIBRATO_TOKEN` and `LIBRATO_SOURCE` are also used within [librato-rails](https://github.com/librato/librato-rails so if you use that gem and configure it also with environment variables you are good to go right away.

## Usage

Librato Rake Deploytrack should be pretty simple to integrate into your deploy process. You just have to wrap your actual deploy call with the two rake tasks. Here is a small example

```bash
#scripts/my_deploy.sh
rake librato:deploy:start['Deploy v47', 'This deploy fixes #63 #67 #74 and also improves performance']
git push heroku master
rake librato:deploy:end
```

As you see the `librato:deploy:start` takes two arguments:

 * `title` The title of an annotation is a string and may contain spaces. The title should be a short, high-level summary of the annotation e.g. v45 Deployment. The title is a required parameter to create an annotation.
 * `description` The description contains extra meta-data about a particular annotation. The description should contain specifics on the individual annotation e.g. Deployed 9b562b2: shipped new feature foo! A description is not required to create an annotation.

### Usage in Travis CI

You have a `before_deploy` and a `after_deploy` run level you can use like this

```yaml
before_deploy:
  - rake librato:deploy:start["deploy $TRAVIS_REPO_SLUG","Travis deployed https://github.com/<your-org>/<your-repo>/compare/$TRAVIS_COMMIT_RANGE"]
after_deploy:
  - rake librato:deploy:end
```

Using this gem in Travis CI deployment has a few pitfalls. First of all it requires your user and token in the environment. You can solve the non-that-secret user with a [global environment variable](http://docs.travis-ci.com/user/build-configuration/#Set-environment-variables) but to keep your token secret it's highly recommended to [encrypt it](http://docs.travis-ci.com/user/encryption-keys/)! Here is a example how a environment config could look like. 

```yaml
env:
  global:
    - LIBRATO_USER=user@example.com
    - secure: "SJXa[...just...a...bunch...of...chars...]e5uofDKs="
```

*this one depends on the deployment provider you are using*
One last thing to solve. Travis usually cleans up your repo before deploying, that would mean that the state-keeping-file would also be deleted. To avoid this you should skip the cleaning. With heroku you can do it with the `skip_cleanup: true` parameter.

## Contribute

1. Fork
2. Hack away
3. Send PR

Really. That's it.
No fancy shitty overhead. But you could write tests if you like <3

## License

The MIT License (MIT)

Copyright (c) 2014 Ole Michaelis - Jimdo GmbH

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
