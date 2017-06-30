class Game

    attr_accessor :player_1, :player_2, :board, :winningToken

   WIN_COMBINATIONS = [
     [0,1,2],
     [3,4,5],
     [6,7,8],
     [0,3,6],
     [1,4,7],
     [2,5,8],
     [0,4,8],
     [2,4,6]
   ]

   def initialize( player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board=Board.new )
     @player_1 = player_1
     @player_2 = player_2
     @board = board
     @winningToken = ""
     #start
   end

   def current_player
     @board.turn_count % 2 == 0 ? @player_1 : @player_2
   end

   #def full?
    # !@board.cells.include?(" ")
   #end

   def over?
     won? || draw?# || full?
   end

   def won?
     # Return indexes if there is a win, otherwise detect return nil
     WIN_COMBINATIONS.detect do |win_combination|

       position_1 = @board.cells[win_combination[0]]
       position_2 = @board.cells[win_combination[1]]
       position_3 = @board.cells[win_combination[2]]

       (position_1 == "X" && position_2 == "X" && position_3 == "X") ||
          (position_1 == "O" && position_2 == "O" && position_3 == "O")
          #puts "Winning Indexes: #{win_combination[0]}, #{win_combination[1]}, #{win_combination[2]}!"
          # We found a winning combination
     end

   end # won?

   def draw?
     @board.full? && !won?
   end

   def winner
     if winningMove = won?
       @winningToken = @board.cells[winningMove[0]]
       #puts "Winning Token:#{@winningToken}."
       @winningToken
     end
   end

   def valid_move?( index )
     index.between?(0,8) && @board.cells[index] == " "
   end

   def turn

       @board.display

       player = current_player
       #print "\nCurrent player token:#{player.token}"
       index = player.move( @board ).to_i - 1

       if valid_move?( index )
         @board.cells[index] = player.token
       else
         turn
       end

   end # end turn

   def play

     #start
     while !over?
       turn
     end

     if draw?
       puts "Cat's Game!"
     end
     if won?
       winningMove = won?
       #puts "Congratulations #{@board.cells[winningMove[0]]}!"
       puts "Congratulations #{winner}!"
       @board.display
     end

   end

end
