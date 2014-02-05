class CardsController < ApplicationController
	
	 before_filter :signed_in_user, only: [:create, :new, :edit, :update]
	 before_filter :check_book_owner, only: []

	 @@day = 0
	 @@view = 0
  # gon.view = @@view


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

    # make the stacks available to js via gon
    gon.practice_stack = Stack.find(2).cards
    gon.reserve_stack = Stack.find(1).cards
    gon.learned_stack = Stack.find(3).cards

	 	# fill the practice pile taking enough cards from the reserve pile to make it 5 cards
	  if Stack.find(2).cards.length < 5
	 		direct_the_flow_of_cards_to_practice_pile()
	 	end
    
    # after 5 days, after the practice pile has been viewed 3 times, the top card is transferred to the 
    # already learned pile
    if @@view == 3 && @@day >= 5
    	transfer_first_card_from_practice_pile_to_reserve_pile()
    	@@view = 0
    	@@day += 1
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
   	@cards = Card.all
   	@topics = Topic.all 
   	@stack = Stack.all
   	new_card = params.require(:card).permit(:title, :content)
    @card =  Card.create(new_card)
    Stack.find(1).cards << @card
    redirect_to reserve_path
 end
    
   def show
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

    def direct_the_flow_of_cards_from_reserve_stack_to_practice_stack()
    	length_practice_stack = Stack.find(2).cards.length
    	length_reserve_stack = Stack.find(1).cards.length
    	if length_practice_stack < 5  && (length_reserve_stack >= (5 - length_practice_stack))
           (5 - length_practice_stack).to_i.times do 
    				put_the_top_card_of_reserve_card_in_last_position_in_practice_pile()
    			end
    	elsif length_practice_stack < 5 && (length_reserve_stack < (5 - length_practice_stack)) 
    			while Stack.find(2).cards.length < 5  &&   Stack.find(1).cards.length > 0 do
    				put_the_top_card_of_reserve_card_in_last_position_in_practice_pile()
    			end
    		end
    end

    def 	transfer_first_card_from_practice_pile_to_reserve_pile()
    	card_to_move = (Stack.find(2).cards)[0]
   	  Stack.find(2).cards.delete(card_to_move)
      Stack.find(3).cards << card_to_move
    end
	 	
end
