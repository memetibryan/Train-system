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

  get('/trains/new') do
  	erb(:train_form)
  end

  get('/towns/new') do
  	erb(:town_form)
  end

  post("/towns") do
    name = params.fetch("name")
    town = Town.new({:name => name, :id => nil})
    town.save()
    @towns = Town.all()
    erb(:add_success)
  end

  post("/trains") do
    name = params.fetch("name")
    train = Train.new({:name => name, :id => nil})
    train.save()
    @trains = Train.all()
    erb(:add_success)
  end