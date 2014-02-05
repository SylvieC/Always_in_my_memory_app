// var last_id === gon.practice_stack.cards.last.id

var view = 0
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
    	$("#" + cardId).show();
    	// if (cardId === gon.practice_stack.last.id) {
    	// 	view += 1;
    	// }
     });
     


  });