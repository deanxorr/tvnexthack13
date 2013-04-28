require 'csv'

class SoundtrackFinder
  class << self
  def get_soundtrack_iframe(entity)
    clean = entity.downcase
    output = []
    get_spotify_id(clean).each do |id|
      output << id[1]
    end
    output
  end
  
  def get_spotify_id(entity)
    CSV.parse(File.open("#{Rails.root}/songs.txt")).sort.uniq { |s| s[0] }.select do |song|
      song[0].downcase.match("#{entity}")
    end.reject {|e| e[0].downcase.match(/(motion | movie | film)/) || e[2].downcase.match(/(motion | movie | film)/) }
  end
  end
end