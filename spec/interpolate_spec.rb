require_relative '../lib/interpolate'

describe Interpolate do
  describe "zerofill" do
    it "fills the missing gaps in data with zeroes" do
      orig = [ [2, 4], [5, 4], [6, 1], [8, 2] ]
      done = [ [1, 0], [2, 4], [3, 0], [4, 0], [5, 4], [6, 1], [7, 0], [8, 2], [9, 0], ]
      Interpolate.zerofill(0, 10, 1, orig).should == done
    end

    it "remaps close points to exact steps" do
      orig = [ [2, 4], [3.05, 4], [3.95, 1], [5, 2] ]
      done = [ [2, 4], [3, 4], [4, 1], [5, 2] ]
      Interpolate.zerofill(2, 5, 1, orig).should == done
    end

    it "remaps close points to exact steps" do
      orig = [ [1.89, 4], [3.05, 4], [3.95, 1], [5.1, 2] ]
      done = [ [2, 4], [3, 4], [4, 1], [5, 2] ]
      Interpolate.zerofill(2, 5, 1, orig).should == done
    end

    it "skips duplicates" do
      orig = [ [2, 4], [3.5, 4], [3.64, 3], [3.95, 1], [5, 2] ]
      done = [ [2, 4], [3, 4], [4, 3], [5, 2] ]
      Interpolate.zerofill(2, 5, 1, orig).should == done
    end
  end
end
