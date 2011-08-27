module Ficsr

  CATEGORIES =  { :b => :blitz, :s => :standard, :B => :Bughouse, :l => :lightning, 
                  :w => :wild,  :L => :losers,   :u => :untimed,  :x => :atomic,
                  :S => :Suicide, :e => :examined_game, :z => :crazyhouse
                }
  class Game
    def initialize(game_def)
      game_regexp = %r{
      (?<number>^\d*){0}
      (?<white_rating>\S*){0}                  
      (?<white_handle>\S*){0}                  
      (?<black_rating>\S*){0}                  
      (?<black_handle>\S*){0}                  
      (?<private>p?){0}                  
      (?<category>\w?){0}                  
      (?<rated>\w?){0}                  
      (?<start_minutes>\d*){0}                  
      (?<increment_seconds>\d*){0}                  
      (?<time_white>\d*:\d*:?\d*){0}                  
      (?<time_black>\d*:\d*:?\d*){0}                  
      (?<strength_white>\d*){0}                  
      (?<strength_black>\d*){0}                  
      (?<turn>[WB]){0}                  
      (?<move_number>\d*){0}                  
      
      \g<number>\s*\g<white_rating>\s*\g<white_handle>\s*\g<black_rating>\s*\g<black_handle>\s*\[\g<private>\s*
      \g<category>\s*\g<rated>\s*\g<start_minutes>\s*\g<increment_seconds>\]\s*\g<time_white>\s*-\s*
      \g<time_black>\s*\(\s*\g<strength_white>\s*-\s*\g<strength_black>\)\s\g<turn>:\s*\g<move_number>$
      
      }x

      match_data = game_def.match(game_regexp)
      if match_data
        self.number             = match_data[:number].to_i
        self.white_rating       = match_data[:white_rating]
        self.white_handle       = match_data[:white_handle]
        self.black_rating       = match_data[:black_rating]
        self.black_handle       = match_data[:black_handle]
        self.private            = !match_data[:private].empty?
        self.category_id        = match_data[:category].to_sym
        self.rated              = match_data[:rated]
        self.start_minutes      = match_data[:start_minutes].to_i
        self.increment_seconds  = match_data[:increment_seconds].to_i
        self.time_white         = match_data[:time_white]
        self.time_black         = match_data[:time_black]
        self.strength_white     = match_data[:strength_white].to_i
        self.strength_black     = match_data[:strength_black].to_i
        self.turn               = match_data[:turn]
        self.move_number        = match_data[:move_number].to_i
      else
        p "ignoring game '#{game_def}'"
      end
    end

    attr_accessor :number, :white_rating, :white_handle, :black_rating, :black_handle, :private, :category_id, :rated, :start_minutes, :increment_seconds, :time_white, :time_black, :strength_white, :strength_black, :turn, :move_number

    def private?
      self.private
    end

    def category
      CATEGORIES[self.category_id]
    end

    def rated?
      self.rated == "r"
    end

    def whites_turn?
      self.turn == "W"
    end
  end
end
