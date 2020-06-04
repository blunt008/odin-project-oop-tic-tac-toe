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
               @previous_moves << move_on_board
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
    def initialize(name, marker, level, starts)
        super(name, marker)
        @level = level 
        @starts = starts
    end 

    def make_move(winning_combinations, board)
        if @level == "easy"
            move = check_move_easy(board, winning_combinations)
        elsif @level == "medium"
            puts "MEDIUM"
        elsif @level == "hard"
            move = check_move_hard(board, winning_combinations)
        end 
        move_as_integer = move.to_i
        board[move_as_integer] = marker
    end 

    def check_move_easy(board, winning_combinations)
        move_available = false
        while !move_available do 
            player_move = rand(1..9)
            move_on_board = board.index(player_move.to_s)
            if move_on_board
                move_available = true  
               @previous_moves << move_on_board
            else
                next 
            end 
        end 
        return move_on_board
    end 
    def check_move_hard(board, winning_combinations)
        if @starts == true 
            first_move = ["1", "3", "7", "9"]
            player_move = rand(0..3)
            move_on_board = board.index(first_move[player_move])
            @previous_moves << first_move[player_move]
            @starts = false 
            return move_on_board
        end 
        
        winning_combinations.each do |combo| 
            possible_moves = combo - previous_moves
            if possible_moves.length < 3 
                p possible_moves
                possible_moves.each do |move|
                    p move
                end
            end 
        end 


        # move_available = false
        # while !move_available do 
        #     player_move = rand(1..9).to_s
        #     move_on_board = board.index(player_move)
        #     if move_on_board
        #         move_available = true  
        #        @previous_moves << player_move
        #     else
        #         next 
        #     end 
        # end 
        # return move_on_board
    end 
end 



