require_relative '../config/environment'

class QuestionChecker

    attr_accessor :question, :answer, :hints, :user_input, :possible_typo

    def initialize(question, answer, hints=nil)
        @question = question
        @answer = answer
        @hints = hints
    end

    def compare_answers 
        output_question
        response = process_user_input
        return response if response == "Timer Expired"
        downcase_comparison
        answer_correct? ? true : process_wrong_answer
    end

    def process_wrong_answer
        @possible_typo = spell_checker
        if typo_is_wrong_answer?
            process_correct_answers
        else 
            let_user_retype
        end
    end

    def process_correct_answers
        formatted_answers = self.answer.map do |answer| 
            answer.split.map(&:capitalize).join(' ')
        end
        return formatted_answers[0...3]
    end

    def process_user_input
        user_input_thread = Thread.new {Thread.current[:value] = STDIN.gets.chomp}

        timer = Thread.new {sleep 15; user_input_thread.kill; puts}
        user_input_thread.join

        if user_input_thread[:value]
            timer.kill
            if user_input_thread[:value] == "h" || user_input_thread[:value] == "hint"
                Hint.give_hint(hints) 
                user_input_thread[:value]= STDIN.gets.chomp 
            end
            self.user_input = user_input_thread[:value]
        else
            return "Timer Expired"
        end
    end

    def output_question
        puts self.question
    end

    def answer_correct?
        self.answer.include?(self.user_input) 
    end

    def typo_is_wrong_answer?
        (self.answer - self.possible_typo) == self.answer
    end

    def let_user_retype
        puts "Did you mean: #{self.possible_typo.join(" or ").red}? Please type your answer again!"
        compare_answers
    end    

    def downcase_comparison
        
        self.user_input = self.user_input.downcase
        self.answer = self.answer.map{|answer| answer.downcase}
    end

    def spell_checker
        spell_checker = DidYouMean::SpellChecker.new(
            dictionary: [
                station_names = Station.get_all_station_names, 
                line_names = Line.get_all_line_names,
                colour_names = Line.get_all_line_colours
            ].flatten
        )
        spell_checker.correct(self.user_input)
    end 
end