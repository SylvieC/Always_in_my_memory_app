$(window).load(function(){
    $(".answer").hide();

    $(".front").click(function(){
    	var cardId = $(this).data("card");
    	$("#" + cardId).show();
    });
  });
