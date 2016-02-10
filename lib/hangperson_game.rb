class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
    
  # end
  
  def initialize(word)
    @word = word
    @guessed = ''
    @wrong_guesses = ''
  end
  
  def word
    @word
  end
  
  def guesses
    @guessed
  end

  def wrong_guesses
    @wrong_guesses
  end
  
  def letter?(lookAhead)
    lookAhead =~ /[[:alpha:]]/
  end
  
  def already_guessed?(val)
    if @guessed.downcase.include? val.downcase or @wrong_guesses.downcase.include? val.downcase
      return true
    end
  end
  
  def guess (val)
    if !letter?(val)
      raise ArgumentError, 'Letter is not valid'
    end
    
    if already_guessed?(val) == true
      return false
    end
    
    if @word.include? val
      @guessed.concat(val)
    else
      @wrong_guesses.concat(val)
    end
  end
  
  def word_with_guesses
    final_string = ''
    @word.split("").each do |i|
      if @guessed.include? i
        final_string.concat(i)
      else
        final_string.concat("-")
      end
    end
    return final_string
  end
  
  def check_win_or_lose
    final_string  = word_with_guesses
    
    if @wrong_guesses.length >= 7
      return :lose
    end
    
    if final_string == @word
      return :win
    else
      return :play
    end
  
  end
  
  
    
  

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
