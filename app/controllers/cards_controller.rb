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
		redirect_to show_path
	 
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
   	@cards = Card.all
   	@topics = Topic.all 
   	@stack = Stack.all
   	 new_card = params.require(:card).permit(:title, :content)
     @card =  Card.create(new_card)
     #the stack with id = 1 is the stack that contains the cards in reserve and is called reserve_stack
     #the cards in the reserve stack are the reserve_stack.cards ( an array)
     #To add a card to the reserve pile, I just push the newly created card in the reserve_stack.cards
     @reserve_stack = Stack.all.find(1)
     @reserve_stack.cards << @card
     redirect_to reserve_path
	 end
    
   def show
   	 reserve_stack = Stack.all.find(1)
	  practice_stack = Stack.all.find(2)
	 	number_of_cards_in_reserve_pile = reserve_stack.cards.length
   	number_of_cards_in_practice_pile = practice_stack.cards.length
	  number = decide_how_many_cards_to_take_from_reserve_pile()
	  make_card_change_stack(reserve_stack,practice_stack number)

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
    	  (number_of_elements).times  do
    	  final_stack.cards.push(original_stack.cards.shift())
    	end
   end



   def decide_how_many_cards_to_take_from_reserve_pile()
   	 number_of_cards_in_reserve_pile = Stack.all.find(1).cards.length
   	 number_of_cards_in_practice_pile = Stack.all.find(2).cards.length
   	 diff_between_reserve_pile_and_practice_pile = number_of_cards_in_reserve_pile - number_of_cards_in_reserve_pile
   	 if (5 - number_of_cards_in_practice_pile) <= number_of_cards_in_reserve_pile
   	   return (5 - number_of_cards_in_practice_pile)
   	 else
   	    return number_of_cards_in_reserve_pile
   	  end
   	end
   	 	 


   
	 	
end
