# Juno

[![Build Status](https://travis-ci.org/allistera/juno.svg?branch=master)](https://travis-ci.org/allistera/juno)
[![Test Coverage](https://codeclimate.com/github/allistera/juno/badges/coverage.svg)](https://codeclimate.com/github/allistera/juno/coverage)

[Juno Trello Board](https://trello.com/b/1KHVf8Z5/juno)

![Site Details View](screenshot.png)

## Features

* HTTP Health Checking
* Custom Status Codes
* Slack Notifications
* Multi-User

## Requirements

There are no dependencies except having Docker and Docker-Compose installed.

## Quick Start

```
$ git clone https://github.com/allistera/juno.git
$ cd juno
$ docker-compose up
```

The first time Juno is ran you will need to create an administrator account:

```
$ docker exec -d juno bundle exec rake user:create[foo@bar.com,Password]
```

Replacing the email address and password with your own.

Once all the services have started browse to [http://localhost:3000](http://localhost:3000) and login.

## Contribute

## License

[Unlicense](UNLICENSE)
