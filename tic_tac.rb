require_relative "player"

class Game  
    def initialize
        @started = true 
        @winning_combinations = [
            ["1", "2", "3"],
            ["4", "5", "6"],
            ["7", "8", "9"],
            ["1", "4", "7"],
            ["2", "5", "8"],
            ["3", "6", "9"],
            ["1", "5", "9"],
            ["3", "5", "7"]
        ]
        @board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        @counter = 0 
    end 

    def display_board
        system("clear")
        empty_row = "\t\t|\t\t|\t\t"
        separator = "-" * 47
        row0 = "\t#{@board[0]}\t|\t#{@board[1]}\t|\t#{@board[2]}\t"
        row1 = "\t#{@board[3]}\t|\t#{@board[4]}\t|\t#{@board[5]}\t"
        row2 = "\t#{@board[6]}\t|\t#{@board[7]}\t|\t#{@board[8]}\t"
        
        puts empty_row + "\n" + row0 + "\n" + empty_row + "\n" + separator + "\n" + empty_row + "\n" + row1 + "\n" + empty_row + "\n" + separator + "\n" + empty_row + "\n" + row2 + "\n" + empty_row
    end 
    
    def start_game
        while true 
            system("clear")
            puts "Welcome to the tic tac toe!"
            puts  
            puts "Choose a mode: \n" \
            "1. Player vs. Player\n" \
            "2. Player vs. Computer\n" \
            "3. Computer vs. Computer"
            print "Select: "
            select_mode = gets.chomp 
            
            while select_mode != "1" && select_mode != "2" && select_mode != "3" do 
                print "Select: "
                select_mode = gets.chomp
            end 

            case select_mode
            when "1"
                pvp()
            when "2"
                pve()
            end
            restart = restart()
            if restart == "y" 
                @started = true 
                next 
            else 
                break
            end 
        end 
    end 
    
    def pvp 
        player1, player2 = ask_for_names("pvp")
        display_board()
        while @started == true 
            player1.make_move(@winning_combinations, @board)
            check_game_state(player1)
            if @started == false then break end 
            player2.make_move(@winning_combinations, @board)
            check_game_state(player2)
        end 
    end 

    def pve
        player1, player2 = ask_for_names("pve")
        display_board()
        while @started == true 
            player1.make_move(@winning_combinations, @board)
            check_game_state(player1)
            if @started == false then break end 
            player2.make_move(@winning_combinations, @board)
            check_game_state(player2)
        end 
    end 

    def restart
        print "Would you like to play again? [y/N] "
        answer = gets.chomp.downcase 
        while answer != "y" && answer != "n" do 
            print "Would you like to play again? [y/N] "
            answer = gets.chomp.downcase 
        end 

        if answer == "y"
            @board = ["1", "2", "3", "4", "5", "6", "7", "8", "9"] 
            @counter = 0 
        end 

        return answer
    end 

    def check_game_state(player) 
        if @counter == 8
            puts "We have a draw!"
            @started = false 
            display_board()
        else 
            display_board() 
            @counter += 1 
        end 
        @winning_combinations.each do |combo| 
            if combo & player.previous_moves == combo 
                # display_board()
                puts "We have a winner! Congrats #{player.name}"
                @started = false 
            end 
        end 
    end 

    def ask_for_names(mode)
        print "Enter Player 1 name: "
        player1_name = gets.chomp
        print "Enter Player 2 name: "
        player2_name = gets.chomp
        
        print "Enter #{player1_name}'s symbol (X/O): "
        player1_mark = gets.chomp
        while player1_mark != "X" && player1_mark != "O" do 
            print "Enter #{player1_name}'s symbol (X/O): "
            player1_mark = gets.chomp
        end
        puts "#{player1_name} is #{player1_mark}"
        
        if player1_mark == "X"
            player2_mark = "O"
        else
            player2_mark = "X"
        end 
        puts "#{player2_name} is #{player2_mark}"
        if mode == "pvp" 
            player1 = Human.new(player1_name, player1_mark)
            player2 = Human.new(player2_name, player2_mark)
            return player1, player2
        elsif mode == "pve"
            print "Enter difficulty easy/medium/hard: "
            level = gets.chomp 

            while level != "easy" && level != "medium" && level != "hard" do 
                print "Enter difficulty easy/medium/hard: "
                level = gets.chomp 
            end
            player1 = Human.new(player1_name, player1_mark)
            player2 = Computer.new(player2_name, player2_mark, level)
            return player1, player2
        end 
    end 
end 

new_game = Game.new

new_game.start_game
