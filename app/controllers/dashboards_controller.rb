class DashboardsController < ApplicationController
  before_filter :get_dashboard, :only => :dash_json

  def show
    @soundtracks = SoundtrackFinder.get_soundtrack_iframe(params[:entity])
    @stream = GetGlue.get_stream_from_name(params[:entity])
    @image = @stream.first['object']['images']['banner']
    @tms = TMS.new(params[:entity]).attributes
  end

  def dash_json
    respond_to do |format|
      format.html { render :html => @dash }
    end
  end

  private
  def get_dashboard
    puts "PARAM #{params[:entity]}"
    @dash ||= {
      :soundtracks => SoundtrackFinder.get_soundtrack_iframe(params[:entity]),
      :stream => GetGlue.get_stream_from_name(params[:entity]),
      :image => GetGlue.get_stream_from_name(params[:entity]).first['object']['images']['banner'],
      :tms => TMS.new(params[:entity]).attributes
    }
  end
end