// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function (){
  $('.edit-op-btn').click(function(e){
    e.preventDefault();
    e.stopPropagation();
    window.open($(this).attr('href'));
    
  });
});