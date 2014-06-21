class CardsController < ApplicationController
  
   before_filter :signed_in_user, only: [:create, :index,:new, :edit, :update]
   

  def index
      @cards = Card.all
      if Stack.where(name: "reserve", user_id: current_user.id).nil?
        @reserve_stack = Stack.create(name: "reserve", times_viewed_today: 0, user_id: current_user.id)
      end

      if Stack.where(name: "practice", user_id: current_user.id).nil?
        @practice_stack = Stack.create(name: "practice", times_viewed_today: 0, user_id: current_user.id)
      end

      if Stack.where(name: "learned", user_id: current_user.id).nil?
        @learned_stack = Stack.create(name: "learned", times_viewed_today: 0, user_id: current_user.id)
      end

     if  current_user.view.nil?
        View.create(user_id: current_user.id, value: 0)
     end
  end


 def practice
      reserve_stack = Stack.where(user_id: current_user.id, name: "reserve")[0]
      @reserve_pile = Card.where(stack_id: reserve_stack.id)
      practice_stack = Stack.where(user_id: current_user.id, name: "practice")[0]
      @practice_pile = Card.where(stack_id: practice_stack.id).order('id asc')
      learned_stack = Stack.where(user_id: current_user.id, name: "learned")[0]
      @learned_pile = Card.where(stack_id: learned_stack.id)
   


      @topics = Topic.all
        # make the stacks available to js via gon
      gon.length = @practice_pile.length
      @view = current_user.view.value

      # fill the practice pile with cards from the reserve pile if needed
      move_the_exact_number_of_cards_needed_from_reserve_pile_to_practice_pile(current_user)
      # create an array with the cards arranged by id number and make the practice_pile be this array
      # of cards before rendering

     

  end
   
  
  def viewed_stack
      @reserve_stack = Stack.where(user_id: current_user.id, name: "reserve")[0]
      @practice_stack = Stack.where(user_id: current_user.id, name: "practice")[0]
      @learned_stack = Stack.where(user_id: current_user.id, name: "learned")[0]

      
   
     @view = current_user.view
     @view.value += 1
     @view.save
      # first 15 times, the stack stays unchanged, then it changes every 3 times.
      if (@view.value % 3 == 0) && (@view.value > 14) && !(@practice_stack.cards).empty?
        move_card_from_top_of_practice_pile_to_already_learned_pile(current_user)
        if !(@practice_stack.cards).empty?
            move_one_card_from_top_of_reserve_pile_to_practice_pile(current_user)
        end
      end
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
    new_card = params.require(:card).permit(:title, :content,:imgurl)
    @card =  Card.create(new_card)
    @reserve_stack = Stack.where(user_id: current_user.id, name: "reserve")[0]
    @reserve_stack.cards << @card
    redirect_to reserve_path(current_user.id)
  end
    
  def show
  end

  def edit
  end

  def learned
     @practice_stack = Stack.where(user_id: current_user.id, name: "practice")[0]
     @learned_stack = Stack.where(user_id: current_user.id, name: "learned")[0]
  end

    
  def destroy
    id = params[:id]
    card = Card.find(id)
    card.delete
    redirect_to reserve_path(current_user.id)
  end
  private

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
    @practice_pile = Card.where(stack_id: @practice_stack.id).order('id asc')
    if @practice_pile.length > 0
      card_to_move = @practice_pile.first
      @practice_pile.delete(card_to_move)
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