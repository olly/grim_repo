require 'spec_helper'
require 'grim_repo/language'

describe GrimRepo::Language do
  describe "#initialize" do
    it "takes the name & number of bytes" do
      language = GrimRepo::Language.new('Ruby', 8434)
      language.name.should == 'Ruby'
      language.bytes.should == 8434
    end
  end
end
