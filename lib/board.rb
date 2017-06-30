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
    puts "\n"
    puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
    puts "-----------"
    puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
    puts "-----------"
    puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
    puts "\n"
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

end
