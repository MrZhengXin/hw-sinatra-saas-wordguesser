class WordGuesserGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/wordguesser_game_spec.rb pass.

  # Get a word from remote "random word" service

  # create getters and setters for the instance variables

  attr_accessor :word, :guesses, :wrong_guesses, :word_with_guesses, :count


  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
    @count = 0
    @word_with_guesses = '-' * @word.length
  end

  def guess(letter)
    # invalid
    if letter == '' or letter =~ /[^a-zA-Z]/ or !letter
      raise ArgumentError
    end

    # case insensitive
    letter=letter.downcase

    # same letter repeatedly
    if guesses.include? letter or wrong_guesses.include? letter
      return false
    end

    @count += 1

    # correctly
    if word.include? letter
      @guesses = letter
      # display correct letter
      word.each_char.with_index do |char, index|
        @word_with_guesses[index] = char if char == letter
      end
    else 
      # incorrectly
      @wrong_guesses = letter
    end

    return true   
  end

  def check_win_or_lose()
    return :win if !@word_with_guesses.include? '-'
    return :lose if @count >= 7
    return :play
  end

  # You can test it by installing irb via $ gem install irb
  # and then running $ irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> WordGuesserGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://randomword.saasbook.info/RandomWord')
    Net::HTTP.new('randomword.saasbook.info').start { |http|
      return http.post(uri, "").body
    }
  end

end
