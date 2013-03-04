require 'spec_helper'
require 'grim_repo/repository'

describe GrimRepo::Repository, fixtures: true do
  let(:client) { mock('Client') }
  let(:repository) { GrimRepo::Repository.new(client, fixture('repository.json')) }

  describe "#initialize" do
    subject { repository }

    its(:name) { should == 'Hello-World' }
    its(:full_name) { should == 'octocat/Hello-World' }
  end

  describe "#forks" do
    let(:forks) { double('Forks') }

    it "initializes & returns Forks" do
      GrimRepo::Forks.should_receive(:new).with(client, repository, count: 9).and_return(forks)

      repository.forks.should == forks
    end
  end

  describe "#languages" do
    let(:languages_uri) { GrimRepo::URIs::RepositoryLanguages['octocat/Hello-World'] }
    let(:languages_data) { { 'Ruby' => 5423, 'Javascript' => 4234 } }

    before { client.stub!(:get).with(languages_uri).and_return(languages_data) }

    it "returns the language names" do
      repository.languages.map(&:name).should =~ ['Javascript', 'Ruby']
    end

    it "returns the language byte count" do
      repository.languages.map(&:bytes).should =~ [4234, 5423]
    end

    it "caches the languages" do
      client.should_receive(:get).once

      2.times do
        repository.languages
      end
    end
  end
end
