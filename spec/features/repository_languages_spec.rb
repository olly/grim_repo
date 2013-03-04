require 'spec_helper'
require 'grim_repo'

describe "fetching a repository's lanaguages", type: :feature, cassette: 'repository_languages' do
  let(:repository) { GrimRepo::Repository.new(client, {'full_name' => 'mojombo/jekyll'})}
  subject { repository.languages }
  
  it { should be_kind_of(Enumerable) }
    
  it "returns all languages" do
    languages = [
      ['Ruby', 135348],
      ['Shell', 25]
    ]

    subject.each do |lanaguage|
      languages.should include([lanaguage.name, lanaguage.bytes])
    end
  end
end
