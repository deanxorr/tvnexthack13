class StreamsController < ApplicationController
  def show
    @interactions = GetGlue.get_stream_from_name(params[:entity])
  end
end