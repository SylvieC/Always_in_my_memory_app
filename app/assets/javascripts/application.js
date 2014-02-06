var length = gon.length;
var count = 0;


$(window).load(function(){
  console.log("hello");
   $(".answer").hide();
 
    $(".front").click(function(){
      var cardId = $(this).data("card");
      count += 1 ;
      $("#" + cardId).show();
   });
  });