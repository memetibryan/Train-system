 require('sinatra')
  require('sinatra/reloader')
  require('./lib/task')
  require('./lib/list')
  also_reload('lib/**/*.rb')
  require("pg")

  DB = PG.connect({:dbname => "to_do"})

  get("/") do
    erb(:index)                                                    
  end