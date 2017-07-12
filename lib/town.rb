class Town
    attr_reader(:name, :id)

    define_method(:initialize) do |attributes|
      @name = attributes.fetch(:name)
      @id = attributes.fetch(:id)
    end

    define_singleton_method(:all) do
      returned_towns = DB.exec("SELECT * FROM towns;")
      towns = []
      returned_towns.each() do |town|
        name = town.fetch("name")
        id = town.fetch("id").to_i()
        towns.push(Town.new({:name => name, :id => id}))
      end
      towns
    end

    define_singleton_method(:find) do |id|
      result = DB.exec("SELECT * FROM towns WHERE id = #{id};")
      name = result.first().fetch("name")
      Town.new({:name => name, :id => id})
    end


    define_method(:save) do
      result = DB.exec("INSERT INTO towns (name) VALUES ('#{@name}') RETURNING id;")
      @id = result.first().fetch("id").to_i()
    end

    define_method(:==) do |another_town|
      self.name().==(another_town.name()).&(self.id().==(another_town.id()))
    end

    define_method(:update) do |attributes|
      @name = attributes.fetch(:name, @name)
      @id = self.id()
      DB.exec("UPDATE towns SET name = '#{@name}' WHERE id = #{@id};")
    end

    define_method(:delete) do
      DB.exec("DELETE FROM towns_trains WHERE town_id = #{self.id()};")
      DB.exec("DELETE FROM towns WHERE id = #{self.id()};")
    end

    define_method(:update) do |attributes|
    @name = attributes.fetch(:name, @name)
    DB.exec("UPDATE towns SET name = '#{@name}' WHERE id = #{self.id()};")

    attributes.fetch(:train_ids, []).each() do |train_id|
      DB.exec("INSERT INTO towns_trains (town_id, train_id) VALUES (#{self.id()}, #{train_id});")
    end
  end

  define_method(:trains) do
    town_trains = []
    results = DB.exec("SELECT train_id FROM towns_trains WHERE town_id = #{self.id()};")
    results.each() do |result|
      train_id = result.fetch("train_id").to_i()
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
      name = train.first().fetch("name")
      town_trains.push(Train.new({:name => name, :id => train_id}))
    end
    town_trains
  end
end