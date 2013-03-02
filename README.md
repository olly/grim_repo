# GrimRepo

An idiomatic Ruby wrapper for the GitHub v3 API – for humans, not computers.

## Installation

Add this line to your application's Gemfile:

    gem 'grim_repo'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install grim_repo

## Usage

### The Client

The Client is the main entry point of the gem. All objects created using a particular client will retain a reference to it and use that for further API calls when accessing related resources.

    username, password = 'grimrepo', 'hub'
    client = GrimRepo::Client.new(username, password)

### The Client's User

The Client is performing operations on behalf of a GitHub user.

    user = client.user
    # => #<GitHub::User:0x007fbe52068638>

    user.login
    # => 'grimrepo'

### Fetching Other Users

We can also fetch the details of other individual users.

    user = client.users('olly')
    # => #<GitHub::User:0x007fbe5209b998>

    user.login
    # => 'olly'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

### Running the Tests

Run the test suite with:

    $ rspec

There tests in `spec/features` hit the live API and capture the results using VCR. If you want to run the tests against the live API you'll need to configure some credentials using environment variables:

    $ export GRIMREPO_TEST_USERNAME=username
    $ export GRIMREPO_TEST_PASSWORD=password
    $ rspec
