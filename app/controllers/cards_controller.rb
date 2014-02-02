class CardsController < ApplicationController
	
	before_filter :signed_in_user, only: [:create, :new, :edit, :update]
	 before_filter :check_book_owner, only: []
	def home 
	end

	 def index
	 	@cards = Card.all 
	 end

	 def practice
	 	@cards = Card.all 
	 end

	 def reserve
	 	end

	 	def create
	 		redirect_to reserve_path
	 	end

	 	def show
	 	end

	 

end
