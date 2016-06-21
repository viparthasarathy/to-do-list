# To-do List
  This Sinatra application allows users to create to-do lists in order to keep track of daily tasks. Users can add steps to their tasks to clarify what needs to be done before reaching completion. The application requires users to create an account and log in before interacting with to-do lists. The back-end of this application utilizes Sinatra and ActiveRecord as the MVC framework and sqlite3/PostgreSQL as the database for development and production respectively. The front-end of this application utilizes the Bootstrap framework for styling purposes and JQuery in order to render and hide forms as needed.
  
## Host on Local Environment
Clone this directory to your local environment and execute:
```
 $ bundle install
```

You should afterwards have access to the shotgun gem which will allow you to run the application on your local environment through the following command:

```
  bundle exec shotgun
```

You should now be able to sign up, log in, and create to-do lists.

## Demo

You can see a demo of this project [here](https://evening-island-43721.herokuapp.com/) hosted via Heroku.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/viparthasarathy/to-do-list.
