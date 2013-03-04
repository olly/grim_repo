module GrimRepo
  class Language
    def initialize(name, bytes)
      @name = name
      @bytes = bytes
    end

    # Number of bytes of code written in that language.
    # @return [Fixnum]
    attr_reader :bytes

    # @return [String]
    attr_reader :name
  end
end
