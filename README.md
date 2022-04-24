# README
## Setup
1. Install ruby v3. I'd recommend [rbenv](https://github.com/rbenv/rbenv)
2. Install bundler `gem install bundler`
3. Install postgresql `brew install postgresql`
4. Start postgres `brew services start postgresql`
5. Install dependencies `bundle install`
6. Start the server `rails s`
7. Visit the site in your [browser](http://localhost:3000)

## Desired features

If given more time, I'd like to put a lot more into the error handling. Right now it handles errors gracefully, but it doesn't really put the user in a position to work with the errors. I'd love to think through a good way to surface the ActiveModel errors per line, i.e. `Line 4: email address invalid` but for the scope of this, I stuck with a basic "An error occurred". I'd also like to think through a better way to sort and filter for when we have more customers than can / should fit on the page. We'd probably need some pagination and a series of search / filter inputs.
