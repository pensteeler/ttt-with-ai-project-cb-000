module Players
  class Computer < Player

    def move( board )

      preferred_cells = ["5", "1", "3", "7", "9", "2", "4", "6", "8"]
      i=0
      #while board.cells[preferred_cells[i].to_i] != " "
      while board.taken?( preferred_cells[i].to_i )
        i += 1
      end
      move = preferred_cells[i]

    end

  end #class Computer
end # module Players
