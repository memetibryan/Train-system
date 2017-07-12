require("rspec")
  require("pg")
  require("train")
  require('town')

  DB = PG.connect({:dbname => "train_test"})  #linked a test database so as not to delete the actual data in the databsae when testing.

  RSpec.configure do |config|
    config.after(:each) do
      DB.exec("DELETE FROM trains *;")
      DB.exec("DELETE FROM towns *;")
    end
  end