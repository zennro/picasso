require 'sqlite3'

class DB
  def initialize(db_name = ":memory:")
    @db_name = db_name

    open_db
    initialize_schema
  end

  def insert(timestamp, tag, variable, value)
    @db.execute("INSERT INTO data (timestamp, tag, variable, value) VALUES (?, ?, ?, ?)", timestamp, tag, variable, value)
  end

  def select(tag, variable, from, to)
    @db.execute("SELECT timestamp, value FROM data WHERE timestamp > ? AND timestamp <= ? AND tag = ? AND variable = ?", from, to, tag, variable)
  end

  private

  def open_db
    @db = SQLite3::Database.new(@db_name)
  end

  def initialize_schema
    @db.execute("CREATE TABLE IF NOT EXISTS data (timestamp integer, tag varchar(255), variable varchar(255), value numeric)")
  end
end
