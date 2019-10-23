class Station < ActiveRecord::Base
    has_many :stops
    has_many :lines, through: :stops

    def self.get_all_station_names
        self.all.map{|station| station.name.downcase}
    end

    def self.stations_by_letter(letter)
        self.all.select{|station| station.name[0] == letter}
    end
  
    def self.station_names_by_letter(letter)
        stations_by_letter(letter).map{|station| station.name}
    end

    def self.all_stations_by_line_id(line_id)
        Stop.all.select {|stop| stop.line_id == line_id}.flatten
    end

    def self.station_id_array_by_line(line_id)
        all_stations_by_line_id(line_id).map {|stop| stop.station_id}
    end

    def self.station_names_on_line(line_id)
        station_id_array_by_line(line_id).map {|station_id| self.find_by(id:station_id).name}
    end

    def self.stations_on_line_by_letter(letter)
        station = self.stations_by_letter(letter).sample
        line = station.lines.sample
        possible_stations = station_names_on_line(line.id).select{|station|station[0]==letter}

        pair = [possible_stations, line.name]
    end
    
    def self.zone_of_station(station)
        if station.zone % 1 == 0
            return [(station.zone.to_i).to_s]
        else 
            return [(station.zone.to_i).to_s, (station.zone.to_i + 1).to_s]
        end
    end

end