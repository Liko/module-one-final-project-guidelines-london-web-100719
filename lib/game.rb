require_relative '../config/environment'


class Game < ActiveRecord::Base  
    
    #  ----- Main methods -----  #
    def self.welcome
        Pictures.print_train_welcome
        ask_for_name
        user_choice
    end

    def self.user_choice
        provide_choices
        enact_choice
    end

    def self.play
        display_question
        if @question == true
            answer_was_correct_so_play_again
        else 
            answer_was_wrong_round_ended
        end
    end

     # ----- End of Main methods ----- #

     # ----- Helper Methods ----- #

    # helper method for welcome an user choice
    def self.prompt
        prompt = TTY::Prompt.new
    end

    #helper method for welcome using self.prompt
    def self.ask_for_name
        @user_input = prompt.ask("Welcome to the Trivial Tube Quiz. What is your name?")
        puts "\nHello #{@user_input} \n \n"
        @user = User.find_or_create_by(username: @user_input)
    end
    
    # provides the choices for the menu and stores answer using self.prompt
    def self.provide_choices
        choices = ["Play", "Rules of The Game", "View Leaderboard", "Change User", "Exit"]
        @user_choice = prompt.select("What would you like to do?", choices)
        end

    # tells you what to do for each choice     
    def self.enact_choice
        if @user_choice == "Play"
            @score = 0
            play
        elsif @user_choice == "View Leaderboard" 
            view_leaderboard
        elsif @user_choice == "Change User" 
            welcome
        elsif @user_choice == "Exit" 
            exit
        else
            Pictures.rules
        end
    end

    # if leaderboard is selected, the leaderboard is printed, user is asked to play again
    # helper method choices
    def self.view_leaderboard
        system('clear')
        puts "Checking the leaderboard...\n"
        print_leaderboard
        user_choice
    end

    # helper method view_leaderboard
    def self.print_leaderboard
        Pictures.the_scores
        sort_scores
        print_headers
        print_scores
    end

    # sorts the scores and selects the top 10
    # helper method view_leaderboard
    def self.sort_scores
        Score.all.sort_by{|score| -score.score.to_i}[0...10]
    end
    
    # prints the headers of the leaderboard with a line 
    # helper method view_leaderboard
    def self.print_headers
        printf("\n                   %-20s %-20s %-20s\n\n", "Position", "Username", "Score")
    end
    
    # prints the top scores on the leaderboard under the headers
    # helper method view_leaderboard
    def self.print_scores
        sort_scores.each_with_index do | score, index |
            username = User.find_by(id: score.user_id).username
            printf("                   %-20s %-20s %-20s\n", index + 1, username, score.score)
        end
        puts "\n"
    end

    # if exit is selected, train says goodbye and leaves
    # helper method choices
    def self.exit
        Pictures.moving_train(15, "Goodbye - please mind the gap on your way out!", 0.1)
    end

    # prints a pretty train and asks a randomly selected tube question
    # helper method play
    def self.display_question
        system('clear')
        print_train
        @question = Question.ask_random_question
    end

    # if the answer was correct, score is increased and displayed, user gets another question
    # helper method play
    def self.answer_was_correct_so_play_again
        @score += 1
        puts "\nCorrect! Your score is now #{@score}".yellow
        sleep(1)
        play
    end
    
    # if the answer was wrong, train leaves, score is displayed and saved, user gets choices again
    # helper method play
    def self.answer_was_wrong_round_ended
        Pictures.moving_train(15, end_message, 0.08)
        save_and_display_score
        user_choice
    end
    
    # score gets saved and displayed
    # helper method answer_was_wrong
    def self.save_and_display_score
        Score.create(user_id: @user.id, score: @score)
        puts "--- Your final score is #{@score.to_s.yellow} --- \n \n"
    end
    
    # depending on why the user lost, a custom message is displayed when the train moves
    # helper method for answer_was_wrong
    def self.end_message
        if @question == "Timer Expired"
            return message = "Oh no! The train has left the station because you were too slow!"
        else 
            return message = "Oh no! The train has left the station because your answer was WRONG! \nThe correct answer(s): #{@question.join(". ")}."
        end  
    end

    # ----- End of Helper methods ---- #
    
    def self.print_train
        system('clear')
        puts "___________   _______________________________________^__        ".yellow 
        puts " ___   ___ |||  ___   ___   ___    ___ ___  |   __  ,----\\     ".green
        puts "|   | |   |||| |   | |   | |   |  |   |   | |  |  | |_____\\    ".cyan
        puts "|___| |___|||| |___| |___| |___|  | O | O | |  |  |        \\   Don't miss the stop!".blue
        puts "           |||                    |___|___| |  |__|         )   You are currently on stop #{@score.to_s.yellow}.".magenta
        puts "___________|||______________________________|______________/    ".red
        puts "           |||                                        /-------- ".yellow
        puts "-----------'''---------------------------------------'          ".yellow
        puts "YOU ONLY HAVE 15 SECONDS TO ANSWER THIS QUESTION".yellow
        puts " \n                                             \n"
    end
    
end