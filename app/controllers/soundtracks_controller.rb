class SoundtracksController < ApplicationController
  def show
    @ids = SoundtrackFinder.get_soundtrack_iframe(params[:entity])
  end
end