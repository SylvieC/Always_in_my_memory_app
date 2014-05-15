var length = gon.length;
var count = 0;
 
$(window).load(function(){
  $("body").on("click","#save", function(ev){
    $("#count_form").submit();
  });
   $(".answer").hide();
 
    $(".front").click(function(){
      var cardId = $(this).data("card");
      count += 1 ;
     $("#" + cardId).show();
     if(count >= length) {
      $("body").append("<div class='save-con'><button id='save' class='btn btn-danger'>SAVE PRACTICE</button></div>");

    }
   })
  });