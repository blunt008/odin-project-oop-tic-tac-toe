    class Player 
    attr_accessor :name, :marker, :previous_moves 
    def initialize(name, marker)
        @name = name 
        @marker = marker
        @previous_moves = [] 
    end
    
    def make_move(winning_combinations, board)
        move = check_move(board)
        move_as_integer = move.to_i
        board[move_as_integer] = marker
    end 

    def check_move(board)
        move_available = false

        while !move_available do 
            print "#{name} your move: "
            player_move = gets.chomp
            if !player_move.to_i.between?(1, 9)
                puts "Select option between 1-9 "
                next 
            end 

            move_on_board = board.index(player_move)

            if move_on_board
               move_available = true  
               @previous_moves << player_move
            else
                puts "Board position taken!"
            end 

        end 

        return move_on_board
    end 
end 

class Human < Player
end 

class Computer < Player
    attr_accessor :level 
    def initialize(name, marker, level)
        super(name, marker)
        @level = level 
    end 

    def make_move(winning_combinations, board)
        move = check_move(board)
        move_as_integer = move.to_i
        board[move_as_integer] = marker
    end 

    def check_move(board)
        move_available = false

        while !move_available do 
            player_move = rand(1..9).to_s
            move_on_board = board.index(player_move)
            if move_on_board
                move_available = true  
               @previous_moves << player_move
            else
                next 
            end 
        end 

        return move_on_board
    end 
    
end 



