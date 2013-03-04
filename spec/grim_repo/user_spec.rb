require 'spec_helper'
require 'grim_repo/client'
require 'grim_repo/user'

describe GrimRepo::User, fixtures: true do
  let(:client) { mock(GrimRepo::Client) }
  let(:user) { GrimRepo::User.new(client, fixture('user.json')) }

  describe "#initialize" do
    subject { user }

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

  describe "#repositories" do
    subject { user.repositories }

    it { should be_instance_of(GrimRepo::Repositories) }
    its(:client) { should == client }
    its(:user) { should == user }
  end
end
