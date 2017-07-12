require("rspec")
  require("pg")
  require("movie")
  require('actor')

  DB = PG.connect({:dbname => "movie_test"})

  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM movies *;")
      DB.exec("DELETE FROM actors *;")
    end
  end