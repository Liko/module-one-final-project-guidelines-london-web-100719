require_relative '../config/environment'

class Pictures

    # Welcome banner
    def self.print_train_welcome
        system('clear')
        puts "________   _______________________________________^__ ".yellow
        puts "_   ___ |||  ___   ___   ___    ___ ___  |   __  ,----\\      __      __       .__ ".green       
        puts " | |   |||| |   | |   | |   |  |   |   | |  |  | |_____\\    /  \\    /  \\ ____ |  |    ____  ____   _____   ____ ".cyan
        puts "_| |___|||| |___| |___| |___|  | O | O | |  |  |        \\   \\   \\/\\/   // __ \\|  |  _/ ___\\/  _ \\ /     \\_/ __ \\".blue
        puts "        |||                    |___|___| |  |__|         )   \\        / \\ ___/|  |_ \\  \\__(  <_> )  Y Y  \\  ___/".magenta
        puts "________|||______________________________|______________/     \\__/\\  /   \\___  >____/\\___  >____/|__|_|  /\\___  >".red
        puts "        |||                                        /-----------    \\/        \\/          \\/            \\/     \\/  ".yellow
        puts "--------'''---------------------------------------' ".yellow
    end

    # ---- logic for moving train ----

    # defines the length of the gap the train will move by
    def self.mind_the_gap(number)
        gap = ""

        number.times do
        gap += "   " 
        end

        gap
    end

    # moves the train by the gap amount a number of times
    def self.moving_train(number, message, sleep)
        
        i = 1

        number.times do
            gap = mind_the_gap(i)
            system('clear')
            
            puts "#{gap}___________   _______________________________________^__        ".yellow 
            puts "#{gap} ___   ___ |||  ___   ___   ___    ___ ___  |   __  ,----\\     ".green
            puts "#{gap}|   | |   |||| |   | |   | |   |  |   |   | |  |  | |_____\\    ".cyan
            puts "#{gap}|___| |___|||| |___| |___| |___|  | O | O | |  |  |        \\   ".blue
            puts "#{gap}           |||                    |___|___| |  |__|         )   ".magenta
            puts "#{gap}___________|||______________________________|______________/    ".red
            puts "#{gap}           |||                                        /-------- ".yellow
            puts "#{gap}-----------'''---------------------------------------'          ".yellow
            
            i += 1
            sleep(sleep)
        end
        train_dissappears(number, message, sleep)
    end

    # makes the end characters dissapear so it looks like the train is moving out of sight
    def self.train_dissappears(number, message, sleep)

        gap2 = mind_the_gap(15)
        i = 1

        number.times do
            gap = mind_the_gap(15 + i)
            system('clear')
            
            puts "#{gap}___________   _______________________________________^__        "[0...-5*i].yellow 
            puts "#{gap} ___   ___ |||  ___   ___   ___    ___ ___  |   __  ,----\\     "[0...-5*i].green
            puts "#{gap}|   | |   |||| |   | |   | |   |  |   |   | |  |  | |_____\\    "[0...-5*i].cyan
            puts "#{gap}|___| |___|||| |___| |___| |___|  | O | O | |  |  |        \\   "[0...-5*i].blue
            puts "#{gap}           |||                    |___|___| |  |__|         )   "[0...-5*i].magenta
            puts "#{gap}___________|||______________________________|______________/    "[0...-5*i].red
            puts "#{gap}           |||                                        /-------- "[0...-5*i].yellow
            puts "#{gap}-----------'''---------------------------------------'          "[0...-5*i].yellow
            
            i += 1
            sleep(sleep)
        end
        puts "#{message}\n".yellow
    end
    # ---- end of logic for moving train ----

    # banner and text for rules page, called in Game.enact_choices
    def self.rules
        system('clear')

        puts "                    __  .__                            .__                   ".yellow
        puts "                  _/  |_|  |__   ____     _______ __ __|  |   ____   ______".green
        puts "                  \\   __\\  |  \\_/ __   \\  \\_  __ \\  |  \\  | _/ __ \\ /  ___/".cyan
        puts "                   |  | |   Y  \\  ___/     |  | \\/  |  /  |_\\  ___/ \\___ \\ ".blue
        puts "                   |__| |___|  /\___  >     |__|  |____/|____/\\___  >____  >".magenta
        puts "                             \\/     \\/                           \\/     \\/ ".red

        puts "\n
        Do you think you know London pretty well? Fancy yourself a true Londoner? Well 
        why don't you play are game and show off your knowledge! \n \n
                                         INSTRUCTIONS
        - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
        The game is simple, answer as many questions as you can correctly, but beware:"
        puts "        YOU ONLY HAVE 15 SECONDS TO ANSWER EACH QUESTION, SO HURRY!".red
        puts "        (Pro tip - you can ask for a 'hint' if you need one...)
        - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - \n \n \n"

       Game.user_choice
    end

    # banner and text for leaderboard page, called in Game.view_leaderboard
    def self.the_scores

    puts "           __  .__                                                 ".yellow      
    puts "         _/  |_|  |__   ____        ______ ____  ___________   ____   ______".green
    puts "         \\   __\\  |  \\_/ __ \\      /  ___// ___\\/  _ \\_  __ \\_/ __ \\ /  ___/".cyan
    puts "          |  | |   Y  \\  ___/      \\___ \\\\  \\__(  <_> )  | \\/\\  ___/ \\___ \\ ".blue
    puts "          |__| |___|  /\\___  >     /____  >\___  >____/|__|    \\___  >____  >".magenta
    puts "                    \\/     \\/           \\/     \\/                 \\/     \\/ ".red

    end


    

end