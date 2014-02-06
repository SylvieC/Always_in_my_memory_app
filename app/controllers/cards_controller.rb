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
    View.create(value: 0)

 end


	def practice
	 	@cards = Card.all
	  @stacks = Stack.all 
	 	@topics = Topic.all

    # make the stacks available to js via gon
    gon.practice_stack = Stack.find(2).cards
    gon.reserve_stack = Stack.find(1).cards
    gon.learned_stack = Stack.find(3).cards
    gon.length = Stack.find(2).cards.length
    gon.views = View.find(1).value
    views = View.find(1).value
    view = View.find(1).value
    day = 1 + view / 3

    # fill the practice pile with cards from the reserve pile if needed
    if (Stack.find(2).cards.length < 5) && (Stack.find(1).cards.length >= (5 - Stack.find(2).cards.length) )
       while (Stack.find(2).cards.length) < 5 && (Stack.find(1).cards.length > 0 )
          move_card_from_top_of_reserve_pile_to_practice_pile()
       end
    end

    #count the days, from days 1 to 5, show the same pile, starting at day 6, the first card of the practice pile
    # is put into the already_learned pile, and one is taken from the reserve pile. The same thing will happen
    # every day, or every 4th viewing of the pile
    if (view % 3 == 0) && (day > 5)
      move_card_from_top_of_practice_pile_to_already_learned_pile()
      move_card_from_top_of_reserve_pile_to_practice_pile()
    end

  end 
   
 def viewed_stack
   view = View.find(1)
   view.value += 1
   view.save
   render nothing: true, status: 201
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
    	card = Stack.find(2).card.where(:id => params[:id])
    	card.delete
    	redirect_to practice_path
    end

  def  move_card_from_top_of_reserve_pile_to_practice_pile()
     card_to_move = Stack.find(1).cards.first
     Stack.find(1).cards.delete(card_to_move)
     Stack.find(2).cards << card_to_move
   end

   def  move_card_from_top_of_practice_pile_to_already_learned_pile()
      card_to_move = Stack.find(2).cards.first
      Stack.find(3).cards << card_to_move
   end
	 	
end
