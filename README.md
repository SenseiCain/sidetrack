# Sidetrack

A Reddit clone. This is a server-side rendered application using Rails and ActionView. Styled with Bootstrap.

## Screenshot

<img src="https://raw.githubusercontent.com/SenseiCain/sidetrack/master/preview.png" width=500>

## Getting started

Currently the application is only available to run locally.

First Fork & Clone this repo, then run the following commands.
```
bundle install
rails db:create
rails db:migrate
rails s
```

There is seed data that can be applied if desired. Data is generated using the Faker gem.
```
rails db:seed
```

## Future Goals

After learning more about JS and RESTful APIs I see a large room for improvement in this application.
Am considering recreating the application in a client-side rendered branch.
