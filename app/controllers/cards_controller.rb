class CardsController < ApplicationController
	
	 before_filter :signed_in_user, only: [:create, :index,:new, :edit, :update]
	 

 def index
      @cards = Card.all
      if Stack.where(name: "reserve", user_id: current_user.id) == nil
        @reserve_stack = Stack.create(name: "reserve", times_viewed_today: 0, user_id: current_user.id)
      end

      if Stack.where(name: "practice", user_id: current_user.id) == nil
        @practice_stack = Stack.create(name: "practice", times_viewed_today: 0, user_id: current_user.id)
      end

      if Stack.where(name: "learned", user_id: current_user.id) == nil
        @learned_stack = Stack.create(name: "learned", times_viewed_today: 0, user_id: current_user.id)
      end

     if  current_user.view == nil
        View.create(user_id: current_user.id, value: 0)
     end
  end


	def practice
      @reserve_stack = Stack.where(user_id: current_user.id, name: "reserve")[0]
      @practice_stack = Stack.where(user_id: current_user.id, name: "practice")[0]
      @learned_stack = Stack.where(user_id: current_user.id, name: "learned")[0]

      @cards = Card.all
    	@topics = Topic.all
        # make the stacks available to js via gon
        
      gon.length = @practice_stack.cards.length
      @view = current_user.view.value

       

        # fill the practice pile with cards from the reserve pile if needed
        
        move_the_exact_number_of_cards_needed_from_reserve_pile_to_practice_pile(current_user)

          # first 15 times, the stack stays unchanged, then it changes every 3 times. 
      if @view % 3 == 0 && @view > 14 && !(@practice_stack.cards).empty?
            move_card_from_top_of_practice_pile_to_already_learned_pile(current_user)
            if !(@practice_stack.cards).empty?
                move_one_card_from_top_of_reserve_pile_to_practice_pile(current_user)
            end
      end

       move_the_exact_number_of_cards_needed_from_reserve_pile_to_practice_pile(current_user)

      end
    

    #count the days, from days 1 to 5, show the same pile, starting at day 6, the first card of the practice pile
    # is put into the already_learned pile, and one is taken from the reserve pile. The same thing will happen
    # every day, or every 4th viewing of the pile
 
   
  
   
 def viewed_stack
   @view = current_user.view
 
   @view.value += 1
   @view.save
   redirect_to "/"
 end
   
  

  def reserve
    @cards = Card.all
	 	@stacks = Stack.all 
	 	@topics = Topic.all
    @reserve_stack = Stack.where(user_id: current_user.id, name: "reserve")[0]
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
      id = params[:id]
    	card = Card.find(id)
    	card.delete
    	redirect_to reserve_path(current_user.id)
    end

    def  move_one_card_from_top_of_reserve_pile_to_practice_pile(user)
      @reserve_stack = Stack.where(user_id: current_user.id, name: "reserve")[0]
      @practice_stack = Stack.where(user_id: current_user.id, name: "practice")[0]
      if !(@reserve_stack.cards.empty?)
         card_to_move = @reserve_stack.cards.first
         @reserve_stack.cards.delete(card_to_move)
         @practice_stack.cards << card_to_move
      end
    end

   def  move_card_from_top_of_practice_pile_to_already_learned_pile(user)
    @practice_stack = Stack.where(user_id: user.id, name: "practice")[0]
    @learned_stack = Stack.where(user_id: user.id, name: "learned")[0]
    if @practice_stack.cards.length > 0
      card_to_move = @practice_stack.cards.last
      @practice_stack.cards.delete(card_to_move)
      @learned_stack.cards.push(card_to_move)
    end
   end

   def how_many_cards_to_move_from_reserve_pile(user)
     @reserve_stack = Stack.where(user_id: user.id, name: "reserve")[0]
     @practice_stack = Stack.where(user_id: user.id, name: "practice")[0]
     
     reserve_length = @reserve_stack.cards.length
     practice_length = @practice_stack.cards.length
     if ((5 - practice_length) <= reserve_length)
      return (5 - practice_length)
     else
       return reserve_length
     end
  end


  def move_the_exact_number_of_cards_needed_from_reserve_pile_to_practice_pile(user)
   
    num_of_times = how_many_cards_to_move_from_reserve_pile(user).to_i
    for i in (1..num_of_times)
      move_one_card_from_top_of_reserve_pile_to_practice_pile(user)
    end
  end
end
 
