class DashboardsController < ApplicationController
  def show
    @soundtracks = SoundtrackFinder.get_soundtrack_iframe(params[:entity])
    @stream = GetGlue.get_stream_from_name(params[:entity])
    @image = @stream.first['object']['images']['banner']
    @tms = TMS.new(params[:entity]).attributes
  end
end