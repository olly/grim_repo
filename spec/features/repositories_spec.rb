require 'spec_helper'
require 'grim_repo'

describe "fetching repositories", type: :feature, cassette: 'repositories' do
  subject { user.repositories }

  context "public repositories" do
    let(:repositories) { ["bert", "bert.erl", "bertrpc", "bower", "chronic", "clippy", "conceptual_algorithms", "cubesixel", "egitd", "endo", "erlang_pipe", "erlectricity", "erlectricity-presentation", "erlenmeyer", "ernie", "eventmachine", "fakegem", "fixture-scenarios", "git", "git-bzr", "github-flavored-markdown", "github-gem", "glowstick", "god", "gollum-demo", "grit", "homebrew", "jekyll", "jquery", "learn-github", "mastering-git-basics", "mojombo.github.com", "mustache.erl", "octobeer", "omniship", "otp", "play", "primer", "proxymachine", "pyberry", "rakegem", "rebar", "redcarpet", "rsese.github.com", "sample-rpc-server", "scoped", "semver", "semver.org", "sf-vegetarian-restaurants", "tomdoc", "toml", "tpw", "v8", "vanhelsing", "yaws"] }
    let(:user) { client.users('mojombo') }
    
    it { should be_kind_of(Enumerable) }
    
    it "returns all repositories" do
      subject.map(&:name).should =~ repositories
    end
  end

  context "no repositories" do
    let(:user) { client.users('grimrepo') }

    it { should_not have_any }
  end
end
