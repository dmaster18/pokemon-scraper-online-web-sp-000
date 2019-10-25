require_relative '../lib/scraper.rb'

class Pokemon
  attr_accessor :id, :name, :type, :db
  
  def initialize (id: nil, name:, type:, db:)
    @id = id
    @name = name
    @type = type
    @db = db
  end
  
  def self.save(name, type, db)
    pokemon = Pokemon.new(id: nil, name: name, type: type, db: db)
    sql = "INSERT INTO pokemon (name, type) VALUES (?, ?)"
    db.execute(sql, pokemon.name, pokemon.type)
    pokemon.id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end
  
  def self.find(id, db)
    sql = "SELECT*FROM pokemon WHERE id = ?"
    result = DB[:conn].execute(sql, id)[0]
    Pokemon.new(result[0], result[1], result[2], self.db)
    
  end
  
  
end
