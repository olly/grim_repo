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

### Fetching Repositories

We can fetch the repositories of the client's user or the public repositories of another user.

    repositories = client.repositories
    # => #<Repositories:0x007fa37944e908>

    user = client.users('mojombo')
    repositories = user.repositories
    # => #<Repositories:0x007fbca8ac7328>

The container is an [Enumerator][Enumerator] which transparently (and lazily) handles the API pagination.

For example, we can fetch the first 10 repositories, resulting in one HTTP request.

    repositories.take(10)

Or fetch them all, which will issue all the necessary HTTP requests to retrieve all the repositories.

    repositories.to_a

### Repository Forks

The forks container is also an [Enumerator][Enumerator] and also handles the pagination transparently.

    repository.forks
    # => #<Forks:0x007fa6734be800>

We can fetch a number of forks, or get them all.

    repository.forks.take(5)
    repository.forks.to_a

We can also get the count of the forks without any additional HTTP requests, because the count is included in the repository metadata. 

    repository.forks.count
    # => 14

_Note:_ if you pass an argument or use the block syntax this optimisation is by-passed and it will have to fetch all the forks from the API.

### Repository Languages

Fetching the repository's languages is straightforward:

    repository.languages.each do |language|
      puts "#{language.name} (#{languate.bytes})"
    end

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
    
[Enumerator]: http://www.ruby-doc.org/core-2.0/Enumerator.html
