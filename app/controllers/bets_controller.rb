class BetsController < ApplicationController
  def index
  end

  def show
    @bet = Bet.find(params[:id])
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
