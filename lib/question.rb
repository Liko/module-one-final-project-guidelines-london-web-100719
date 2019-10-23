require_relative '../config/environment'
require 'pry'

class Question 

    def self.ask_random_question
        questions.sample.call
    end

    def self.questions
        array = [
            method(:which_line_is_station_on),
            method(:which_line_has_more_stations),
            method(:how_many_lines_go_through),
            method(:station_beginning_with_x),
            method(:station_beginning_with_x_on_line_y),
            method(:which_zone_is_x_station_in),
            method(:what_colour_is_this_line?)
            ]
    end

    def self.checkQuestion(question, answer, hints=nil)
        check = QuestionChecker.new(question, answer, hints)
        check.compare_answers
    end

    def self.which_line_is_station_on
        station = Station.all.sample

        question = "Which line is #{station.name} on?"
        answer = Line.lines_names_of_station(station.id)
        hints = Hint.generate_line_hint(answer)

        checkQuestion(question, answer, hints)
    end

    def self.which_line_has_more_stations
        line_1 = Line.all.sample
        line_2 = (Line.all - [line_1]).sample

        question = "Which of these two lines has the most stops? #{line_1.name} or #{line_2.name}"
        answer = [Line.most_stops(line_1, line_2)]
        
        checkQuestion(question, answer)
    end

    def self.how_many_lines_go_through
        station = Station.all.sample

        question = "How many lines go through #{station.name}?"
        answer = [station.lines.size.to_s]
        hints = Hint.generate_numerical_hint(answer)
 
        checkQuestion(question, answer, hints)
    end

    def self.station_beginning_with_x
        station = Station.all.sample
        letter = station.name[0]

        question = "Name a Station beginning with #{letter}"
        answer = Station.station_names_by_letter(letter)
        hints = Hint.generate_begin_with_hint(answer)
        
        checkQuestion(question, answer, hints)
    end

    def self.station_beginning_with_x_on_line_y
        station = Station.all.sample
        letter = station.name[0]
        
        answer_array = Station.stations_on_line_by_letter(letter)
        answer = answer_array[0]
        line = answer_array[1]
        question = "Name a Station beginning with #{letter} on the #{line} line."
        hints = Hint.generate_begin_with_hint(answer)

        checkQuestion(question, answer, hints)
    end

    def self.which_zone_is_x_station_in
        station = Station.all.sample

        question = "Which zone is #{station.name} in?"
        answer = Station.zone_of_station(station)
        hints = Hint.generate_numerical_hint(answer)

        checkQuestion(question, answer, hints)
    end

    def self.what_colour_is_this_line?
        line = Line.all.sample

        question = "What colour is the #{line.name} line? "
        answer = [line.colour]
        hints = Line.get_all_line_colours

        checkQuestion(question, answer, hints)
    end
end