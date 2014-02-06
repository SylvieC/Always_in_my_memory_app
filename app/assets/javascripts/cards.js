
var view = 0;
var test = 0;
var day = 0;

var stack_length = gon.practice_stack.length;
var practice_stack = gon.practice_stack;
var reserve_stack = gon.reserve_stack ;


$(window).load(function(){
		gon.practice_stack.forEach(function(card) {
		  $(".container").append("" +
		  	"<div class='row'>" + 
					"<div class='col-xs-6'>" +
               "<div data-card=" + card.id + " class='well front'>" + card.title + "</div>" +
            "</div>" +
            "<div class='col-xs-6'>" +
               "<div id='" + card.id + "' class='well answer'>" + card.content + "</div>" +
            "</div>" +
            "<div class='clearfix hidden-md hidden-lg'></div>" +
          "</div>" +
          "<hr>" +
		  	"</div>");
		});

    $(".answer").hide();

    $(".front").click(function(){
    	var cardId = $(this).data("card");
      test += 1;
    	$("#" + cardId).show();
      if (test === stack_length){
        view += 1;
      }

 
     
  //if the practice stack has less than 5 cards, add cards
     if (practice_stack.length < 5)
     {
        fill_practice_pile_from_reserve_pile();
    }

    

   //  //after the initial 5 days (where the practice pile stays unchanged), 
   //  // everytime the stack is viewed, the variable view is incremented by
   //  //1 , after 3 views of a stack, the stack is updated, but taking out a 
   // // the first card of the stack
      if (view % 3 === 0 && day >=5 ){
        transfer_top_card_from_practice_pile_to_already_learned_pile();
        day += 1;
        } 
     });
  });

function fill_practice_pile_from_reserve_pile()
{
  while (practice_stack.length < 5  &&   reserve_stack.length > 0)
    {
      move_top_card_of_reserve_card_to_the_last_position_in_practice_pile();
    } 
};




function move_top_card_of_reserve_card_to_the_last_position_in_practice_pile()
    {
      var card_to_move = reserve_stack[0];
      //change the relationship of that card to stack 1 to be with stack 2
      card_to_move.stack_id = 2;
      practice_stack.push(card_to_move);
    };

function transfer_top_card_from_practice_pile_to_already_learned_pile()
  {
    var card_to_move = learned_stack[0];
    card_to_move.stack_id = 3;
    learned_stack.push(card_to_move);
  };