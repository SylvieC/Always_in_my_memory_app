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
	 		redirect_to new_path
	 	end

	 	def show
	 		@cards = Card.all
	 		
	 	end

	 	def new
	 	end

	 	def edit
	 	end
    
    def destroy
    	card = current_user.cards.where(:id => params[:id])
    	cards.delete
    	redirect_to(cards_path)
    end
	 	

	 

end
