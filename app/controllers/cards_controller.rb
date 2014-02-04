class CardsController < ApplicationController
	
	 before_filter :signed_in_user, only: [:create, :new, :edit, :update]
	 before_filter :check_book_owner, only: []
	def home 
	end

	 def index
     if signed_in?
	  	id = current_user.id
	  	redirect_to user_path(id)
	   end
	   	@reserve_stack = Stack.create()
      @practice_stack = Stack.create(name:  "practice", times_viewed_today: 0)
      @learned_stack = Stack.create(name: "learned", times_viewed_today: 0)
	 end


	def practice
	 	@cards = Card.allI
	  @stacks = Stack.all 
	 	@topics = Topic.all
	 	update_practice_pile = false
	 	if update_practice_pile
	 		direct_the_flow_of_cards_to_practice_pile()
	 	end
	 end



	
  end

	def reserve
	 	@cards = Card.all
	 	@stacks = Stack.all 
	 	@topics = Topic.all

  end

	 

	 def new
        @card = Card.new
   end

   def create
   	   	 
	 		 new_card = params.require(:card).permit(:title, :content)
       @card =  Card.create(new_card)
       @reserve_stack_of_cards = Stack.find(1).cards
       @reserve_stack_of_cards << @card


      

       redirect_to reserve_path
	 end
    
   def show
	 		@cards = Card.all
	 end

   def edit
	 end

	 	def learned
	 	end
    
    def destroy
    	card = current_user.cards.where(:id => params[:id])
    	cards.delete
    	redirect_to(cards_path)
    end

   def put_the_top_card_of_reserve_card_in_last_position_in_practice_pile()
      card_to_move = (Stack.find(1).cards)[0]
   	  Stack.find(1).cards.delete(card_to_move)
      Stack.find(2).cards << card_to_move
    end

    def direct_the_flow_of_cards_to_practice_pile()
    	practice_stack = Stack.find(2)
    	if practice_stack.cards.length > 5
    	end
    end



 
	 	
end
