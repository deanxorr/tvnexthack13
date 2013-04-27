require 'csv'

class SoundtrackFinder
  class << self
  def get_soundtrack_iframe(entity)
    output = []
    get_spotify_id(entity).each do |id|
      output << id[1]
    end
    output
  end
  
  def get_spotify_id(entity)
    CSV.parse(File.open("#{Rails.root}/songs.txt")).sort.uniq { |s| s[0] }.select do |song|
      song[0].match("#{entity}")
    end
  end
  end
end