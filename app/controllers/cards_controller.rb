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
	 	@cards = Card.all
	  @stacks = Stack.all 
	 	@topics = Topic.all
	 	practice_stack = Card.find(2).cards
	 	reserve_stack = Card.fin(1).cards

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
       length_reserve_stack = @reser

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

    def make_card_change_stack(original_stack, final_stack, number_of_elements)
    	  number_of_elements.to_i.times  do
    	  final_stack.push(original_stack.shift())
    	end
   end
	 	
end
