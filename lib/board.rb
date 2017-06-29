class Board

  attr_accessor :cells


    def initialize
      @cells = Array.new(9, " ")
      #@board = board || Array.new(9, " ")
    end

    def reset!
      @cells =  Array.new(9, " ")
    end

  def display
    puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
    puts "-----------"
    puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
    puts "-----------"
    puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
  end

   def input_to_index( inputString )
     inputString.to_i - 1
   end

   def position( index )
     @cells[index.to_i-1]
   end

   def full?
     !@cells.include?(" ")
   end

   def turn_count
     @cells.count{|token| token == "X" || token == "O"}
   end

   def taken?(index)
     !(@cells[index.to_i-1].nil? || @cells[index.to_i-1] == " ")
   end

   def valid_move?(index)
      index.to_i.between?(1,9) && !taken?( index )
   end

   def update( index, player )
     #puts "Player.token:#{player.token}"
     @cells[index.to_i-1] = player.token
   end

#*******************************************

   def move(index, current_player)
     @board[index] = current_player
   end

     def current_player
       turn_count % 2 == 0 ? "X" : "O"
     end


     def turn
       puts "Please enter 1-9:"
       input = gets.strip
       index = input_to_index(input)
       if valid_move?( index)
         move( index, current_player )
         display_board
       else
         turn
       end
     end

     def won?
       # Return indexes if there is a win, otherwise nil
       WIN_COMBINATIONS.each do |win_combination|
         # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
         # grab each index from the win_combination that composes a win.
         win_index_1 = win_combination[0]
         win_index_2 = win_combination[1]
         win_index_3 = win_combination[2]

         position_1 = @board[win_index_1] # load the value of the board at win_index_1
         position_2 = @board[win_index_2] # load the value of the board at win_index_2
         position_3 = @board[win_index_3] # load the value of the board at win_index_3

         #puts "Checking Indexes: #{win_combination[0]}, #{win_combination[1]}, #{win_combination[2]}!"
         #puts "Values: #{position_1}, #{position_2}, #{position_3}!"
         if (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
            (position_1 == "O" && position_2 == "O" && position_3 == "O")
            #puts "Winning Indexes: #{win_combination[0]}, #{win_combination[1]}, #{win_combination[2]}!"
            return win_combination
         end

       end  # do end

       return false  # No winning combinations

     end  # end won?


     def draw?
       # draw? expects false from won? however winner? expexcts nil
       playerWon = won?
       if playerWon == nil
         playerWon = false
       end

       boardFull = full?

         if (playerWon == false) && (boardFull == true)
           true
         elsif (playerWon == false) && (boardFull == false)
           false
         elsif playerWon == true
           false
         else
           false
         end
     end  # end of draw?

     def over?
       if won? || draw? || full?
         return true
       else
         return false
       end
     end

     def winner
         myWinner = won?

         if myWinner != false
           return @board[myWinner[0]]
         else
           return nil
         end
     end

     def play
         until over?
           turn
         end

         if winner != nil
           puts "Congratulations #{winner}!"
         end

         if draw?
           puts "Cat's Game!"
         end
     end  # End of play

end
