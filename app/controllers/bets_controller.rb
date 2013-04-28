class BetsController < ApplicationController
  def index
  end

  def recent
    last_poll = params[:time].to_i - 5
    @bets = Bet.get_recent(last_poll, params[:time].to_i)
  end

  def create
    @bet = Bet.new(params[:bet])
    if @bet.save
      flash[:success] = "Bet successful!"
      redirect_to root_url
    else
      flash[:error] = "Save unsuccessful."
    end
  end
end
