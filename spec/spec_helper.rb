require("rspec")
  require("pg")
  require("train")
  require('town')

  DB = PG.connect({:dbname => "movie_test"})

  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM movies *;")
      DB.exec("DELETE FROM actors *;")
    end
  end