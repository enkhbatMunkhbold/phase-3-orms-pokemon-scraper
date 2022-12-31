require "scraper.rb"
require 'pry'

class Pokemon < Scraper

  attr_accessor :id, :name, :type, :db

  def self.initialize (id=nil, name, type, db)
    @id = id
    @name = name
    @type = type
    @db = db
  end

  def self.save(name, type, db)
    sql = <<-SQL
      INSERT INTO pokemon(name, type)
      VALUES (?, ?)
    SQL

    db.execute(sql, name, type)
    @id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
  end

  def self.find(id, db)
    sql = <<-SQL
      SELECT * FROM pokemon
      WHERE id = ?
    SQL

    result = db.execute(sql, [id])[0]
    Pokemon.new(result[0], result[1], result[2])
    # new_pokemon = Pokemon.new(pokemon_data[0], pokemon_data[1], pokemon_data[2])
    # new_pokemon
    # binding.pry
  end

end
