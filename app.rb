 require('sinatra')
  require('sinatra/reloader')
  require('./lib/train')
  require('./lib/town')
  also_reload('lib/**/*.rb')
  require("pg")

  DB = PG.connect({:dbname => "train_system"})

  get("/") do
    erb(:index)                                                    
  end

  get("/towns") do
    erb(:towns)                                                    
  end

  get("/trains") do
    erb(:trains)                                                    
  end