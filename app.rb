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
  	@towns = Town.all()
    erb(:towns)                                                    
  end

  get("/trains") do
  	@trains = Train.all()
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

  get("/towns/:id") do
    @town = Town.find(params.fetch("id").to_i())
    @trains = Train.all()
    erb(:town_details)
  end

  get("/trains/:id") do
    @train = Train.find(params.fetch("id").to_i())
    @towns = Town.all()
    erb(:train_details)
  end

  patch("/trains/:id") do
    train_id = params.fetch("id").to_i()
    @train = Train.find(train_id)
    town_ids = params.fetch("town_ids")
    @train.update({:town_ids => town_ids})
    @towns = Town.all()
    erb(:train_details)
  end

  patch("/towns/:id") do
    town_id = params.fetch("id").to_i()
    @town = Town.find(town_id)
    train_ids = params.fetch("train_ids")
    @town.update({:train_ids => train_ids})
    @trains = Train.all()
    erb(:town_details)
  end