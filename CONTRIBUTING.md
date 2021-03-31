# Contributing

Follow the guidelines below to contribute to this project.

## Getting started

1. Run the following commands to clone the repository and setup the development environment:

```
git clone https://github.com/autoreleasefool/thebrokenquillsociety.git
cd thebrokenquillsociety
bundle install
rails acts_as_taggable_on_engine:install:migrations db:create db:migrate
```

2. Make your changes
3. Submit a pull request

## Creating an admin account (recommended)

1. Ensure postgresql is running
2. Start the server with 'rails s'. By default, the server will use port 3000, and the homepage will be at http://localhost:3000/
3. Navigate to http://localhost:3000/signup
4. Provide a username, a password of at least 6 characters, and an @uottawa.ca email, then press "Sign up"
5. Run the following commands to make the user with username <name> an admin:
```
rails c
new_admin = User.find_by name: '<name>'
new_admin.update_attribute('is_admin', true)
exit
```
6. This user is now an admin.
