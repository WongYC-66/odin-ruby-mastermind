# GameAI.rb
class GameAI
  # modify rules, hints will be different for AI to tell which index is correct
  def initialize()
    @secrect_code = user_generate_code()
    @round = 1
    @max_round = 12
    @prev_res = [nil, nil, nil, nil]
    @prev_guess = nil
    print_code
  end

  def user_generate_code
    user_str = get_user_input
    return user_str.split('')
  end

  def print_code
    puts @secrect_code.join("")
  end

  def print_game_status
    puts "Round : #{@round}/#{@max_round}"
  end

  def play
    while true
      print_game_status

      if(@round > @max_round)
        print_game_lost   # out of turns
        return
      end
      
      ai_guess_string = get_AI_input
      p ai_guess_string
      res = guess(ai_guess_string)

      if res
        print_game_won    # won
        return
      else
        print_hints(ai_guess_string)   # show hints and continue play
        @round += 1
      end

    end
  end
  
  def valid?(guess_string)
    return false if guess_string.length != 4
    return guess_string.split('').all? { |char| char >= 'A' && char <= 'F' }
  end

  def get_AI_input
    if !@prev_guess
      ai_guess_string = "AAAA"
      @prev_guess = ai_guess_string
      return ai_guess_string
    else
      ai_guess_string = @prev_guess.split('').each_with_index.map do |char, i|
        @prev_res[i] ? char : char.succ
      end
      @prev_guess = ai_guess_string.join('')
      @prev_guess
    end
  end

  def get_user_input
    puts("Please enter your secret key. e.g. ABCD ")
    user_guess_string = gets.chomp.upcase
    until valid?(user_guess_string)
      puts("Invalid, please enter only 4chars between A-F, e.g. ABCD")
      user_guess_string = gets.chomp.upcase
    end
    return user_guess_string
  end

  def guess(guess_str)
    # return Boolean
    return [0,1,2,3].all? { |i| guess_str[i] == @secrect_code[i] } 
  end

  def print_game_lost
    puts("Game ended - Ai Lose")
    puts("the secret code is : ")
    print_code
  end

  def print_game_won
    puts("Ai has Won!")
    puts("the secret code is : ")
    print_code
  end

  def print_hints(guess_str)
    res = []
    @secrect_code.each_with_index do |char, i|
      res.push(char == guess_str[i])
    end
    p res
    @prev_res = res
  end

end