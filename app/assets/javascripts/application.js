var length = gon.length;
var count = 0;
 
$(window).load(function(){
	$("#count_form").on("submit", function(ev){
		ev.preventDefault();
	})
  console.log("hello");
   $(".answer").hide();
 
    $(".front").click(function(){
      var cardId = $(this).data("card");
      count += 1 ;
     $("#" + cardId).show();
     if(count >= length) {
     	console.log("FIRED EVENT")
     	$("#count_form").submit();
		}
   })
  });