class StaticController < ApplicationController
	def home
		@bet = Bet.new()
	end

	def viggle
    render :layout => "stripped"
	end
end
