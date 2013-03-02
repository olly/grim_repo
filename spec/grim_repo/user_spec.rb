require 'spec_helper'
require 'json'
require 'grim_repo/user'

describe GrimRepo::User do
  describe "#initialize" do
    let(:client) { mock(GrimRepo::Client) }
    subject { GrimRepo::User.new(client, fixture('user.json')) }

    it { should_not be_hireable }
    its(:api_url) { should == URI.parse("https://api.github.com/users/octocat") }
    its(:avatar_url) { should == URI.parse('https://github.com/images/error/octocat_happy.gif') }
    its(:bio) { should == 'There once was...' }
    its(:blog) { should == URI.parse('https://github.com/blog') }
    its(:company) { should == 'GitHub'}
    its(:created_at) { should == Time.utc(2008, 1, 14, 4, 33, 35) }
    its(:email) { should == 'octocat@github.com' }
    its(:gravatar_id) { should == 'somehexcode' }
    its(:id) { should == 1 }
    its(:location) { should == 'San Francisco'}
    its(:login) { should == 'octocat' }
    its(:name) { should == 'monalisa octocat' }
    its(:url) { should == URI.parse("https://github.com/octocat") }
  end

  def fixture(filename)
    file = Pathname.new(__dir__).join('..', 'fixtures', 'data', filename)
    JSON.parse(file.read)
  end
end
