
var length = gon.length;
var count = 0;

$(window).load(function(){
  console.log("hello");
   $(".answer").hide();
 
    $(".front").click(function(){
      var cardId = $(this).data("card");
      var t += 1
      $("#" + cardId).show();
   });
  });

//when last one is clicked, send a post
//I can get the length of practice _card with a 
//gone view
$.ajax({
  type: "POST",
  url: url,
  data: data,
  success: success,
  dataType: dataType
});