module GrimRepo
  class User
    def initialize(data)
      @login = data['login']
    end

    attr_reader :login
  end
end
