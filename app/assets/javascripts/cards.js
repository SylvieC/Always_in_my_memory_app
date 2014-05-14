var length = gon.length;
var count = 0;

$(window).load(function() {
//   console.log("hello");
//   $(".answer").hide();

//   $(".front").click(function() {
//     var cardId = $(this).data("card");
//     var t += 1;
//     $("#" + cardId).show();
//   });
// });


  $("body").on("click","#save", function(ev){
    $("#count_form").submit();
  });
  
  console.log("hello");
   
  $(".answer").hide();

  $(".front").click(function(){
    var cardId = $(this).data("card");
    count += 1 ;
    $("#" + cardId).show();
    if(count >= length) {
      console.log("FIRED EVENT")
      $("body").append("<div class='save-con'><button id='save' class='btn btn-danger'>SAVE PRACTICE</button></div>");
    }
  }); // .front click handler
}); // window.onload




//when last one is clicked, send a post
//I got the length of practice_pile with a 
//gon view
$.ajax({
  type: "POST",
  url: '/test',
  data: {name:"blah", age: 30},
  success: function() {
    console.log("SUCCESS!!");
  },
  error: function() {
    console.log("ERROR!!");
  }
  // dataType: dataType
});