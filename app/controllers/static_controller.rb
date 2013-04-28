class StaticController < ApplicationController
	def home
		@bet = Bet.new()
	end

	def viggle
	end
end
