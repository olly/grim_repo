require 'spec_helper'
require 'grim_repo/client/page_links_parser'

describe GrimRepo::Client::PageLinksParser do
  let(:parser) { GrimRepo::Client::PageLinksParser.new }
  let(:env) { {response_headers: headers} }

  def run
    parser.on_complete(env)
  end

  context "with a Link header" do
    let(:headers) { {'Link' => '<https://api.github.com/users/mojombo/repos?page=2>; rel="next", <https://api.github.com/users/mojombo/repos?page=2>; rel="last"' }}

    it "parses correctly" do
      run
      env[:links]['next'].should == URI.parse("https://api.github.com/users/mojombo/repos?page=2")
      env[:links]['last'].should == URI.parse("https://api.github.com/users/mojombo/repos?page=2")
    end
  end

  context "with an empty Link header" do
    let(:headers) { {'Link' => '' } }
    subject { run }

    it { should == {} }
  end

  context "without a Link header" do
    let(:headers) { {'Link' => '' } }
    subject { run }

    it { should == {} }
  end
end
