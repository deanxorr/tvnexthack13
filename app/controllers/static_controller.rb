class StaticController < ApplicationController
	def home
		@bet = Bet.new()
	end
end
