// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/


// following code is to prevent course row from expanding when user clicked edit button of each course row at courses index 
$(document).ready(function (){
  $('.edit-op-btn').click(function(e){
    e.preventDefault();
    e.stopPropagation();
    window.open($(this).attr('href'));
  });

  window.setTimeout(function delayed(){
    if (window.location.hash){
      var anchor = window.location.hash;
      anchor = anchor.replace("heading","collapse");
      console.log(anchor);  // #heading1
      $(anchor).collapse("show");
    }
  },500);


});