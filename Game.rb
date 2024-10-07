# Game.rb
class Game
  def initialize()
    @secrect_code = generate_code()
    @round = 1
    @max_round = 12
  end

  def generate_code
    Array.new(4, " ").map do |_|  # code of 4 chars long
      val = rand(6) + "A".ord     # 6 choices, from A~F
      val.chr
    end
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
      
      user_guess_string = get_user_input
      res = guess(user_guess_string)

      if res
        print_game_won    # won
        return
      else
        print_hints(user_guess_string)   # show hints and continue play
        @round += 1
      end

    end
  end
  
  def valid?(guess_string)
    return false if guess_string.length != 4
    return guess_string.split('').all? { |char| char >= 'A' && char <= 'F' }
  end

  def get_user_input
    puts("Please enter your guess. e.g. ABCD ")
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
    puts("Game ended - You Lose")
    puts("the secret code is : ")
    print_code
  end

  def print_game_won
    puts("You Won!")
    puts("the secret code is : ")
    print_code
  end

  def print_hints(guess_str)
    count = @secrect_code.reduce(Hash.new(0)) do |hash, char| 
      hash[char] += 1
      hash
    end

    guess_str_arr = guess_str.split('')

    exact_match = find_exact_match(guess_str_arr, count)
    fuzzy_match = find_fuzzy_match(guess_str_arr, count)
    
    p "#{guess_str}    ----    #{exact_match} ✓, #{fuzzy_match} ✗ "
    
  end

  def find_exact_match(guess_str, count)
    match_count = 0
    @secrect_code.each_with_index do |char, i|
      if char == guess_str[i]
        match_count += 1
        count[char] -= 1
        guess_str[i] = nil
      end
    end
    return match_count
  end

  def find_fuzzy_match(guess_str, count)
    match_count = 0
    guess_str.each do |char|
      if count[char] >= 1
        match_count += 1
        count[char] -= 1
      end
    end
    return match_count
  end

end