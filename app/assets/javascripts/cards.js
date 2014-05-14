var length = gon.length;
var count = 0;

$(window).load(function() {
  console.log("hello");
  $(".answer").hide();

  $(".front").click(function() {
    var cardId = $(this).data("card");
    var t += 1;
    $("#" + cardId).show();
  });
});

//when last one is clicked, send a post
//I got the length of practice_pile with a 
//gon view
$.ajax({
  type: "POST",
  url: url,
  data: data,
  success: success,
  dataType: dataType
});