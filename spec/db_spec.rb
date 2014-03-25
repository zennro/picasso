require_relative '../lib/db'

describe DB do
  let(:db) { DB.new }

  describe "inserting a value" do
    it "saves the value into the db" do
      db.insert(1000, "server1", "cpu_load", 23.0)
      db.select("server1", "cpu_load", 500, 1500).count.should == 1
    end
  end
end
