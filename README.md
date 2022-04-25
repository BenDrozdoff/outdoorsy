# Outdoor.sy
## Setup
1. Install ruby v3. I'd recommend [rbenv](https://github.com/rbenv/rbenv)
2. Install node v16. I'd recommend using [nvm](https://github.com/nvm-sh/nvm)
3. Install bundler `gem install bundler`
4. Install yarn `npm install --global yarn`
5. Install postgresql `brew install postgresql`
6. Start postgres `brew services start postgresql`
7. Run `bin/setup` to set up the application and start the server at port 3000, or continue with steps 8-12 to do each component on its own
8. Install dependencies `bundle install`
9. Setup the database `rake db:prepare`
10. Start the server on port 3000 `rails s`
11. Visit the site in your [browser](http://localhost:3000) at http://localhost:3000
12. (Optional) run tests with `rspec`

## Desired features

If given more time, I'd like to put a lot more into the error handling. Right now it handles errors gracefully, but it doesn't really put the user in a position to work with the errors. I'd love to think through a good way to surface the ActiveModel errors per line, i.e. `Line 4: email address invalid` but for the scope of this, I stuck with a basic "An error occurred". I'd also like to think through a better way to sort and filter for when we have more customers than can / should fit on the page. We'd probably need some pagination and a series of search / filter inputs.
