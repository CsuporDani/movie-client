# Getting Started

### Prerequisites
* Ruby version 3.1.3
* This application is using PostgresQGL. More info: https://www.postgresql.org/download/
### Installation
1. Get a free API Key at: https://developers.themoviedb.org/3/getting-started/introduction
2. Clone the repo <br />
`git clone https://github.com/CsuporDani/movie-client.git`
3. Install gems <br />
`bundle install`
4. Create new credentials <br />
 `rm ./config/credentials.yml.enc ` delete old <br />
 `rails credentials:edit` create new  <br />
 `TMDB_API_KEY: api_key` add to credentials.yml.enc  <br />
 5. Edit ./config/database.yml
 6. Create database and run migration <br />
 `bundle exec rake db:create db:migrate`
 7. Start server  <br />
 `rails s`

### How to run the test suite
1. Create and migrate database <br />
`rake db:create db:migrate RAILS_ENV=test`
2. Run rspec <br />
` bundle exec rspec`
