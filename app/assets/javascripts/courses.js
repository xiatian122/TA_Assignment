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




// // For Delete Button
// $('button[name="remove_levels"]').on('click', function(e){
//     var $form=$(this).closest('form');
//     e.preventDefault();
//     $('#confirm').modal({ backdrop: 'static', keyboard: false })
//         .one('click', '#delete', function (e) {
//             $form.trigger('submit');
//         });
// });

// // Eample bootstrap code
// <form action ="<?php echo $URL .'/admin/privileges.php?action=editable' ?>" method="POST">
// <button class='btn btn-danger btn-xs' type="submit" name="remove_levels" value="delete"><span class="fa fa-times"></span> delete</button>
// </form>

// <div id="confirm" class="modal hide fade">
//   <div class="modal-body" id="delete-modal">
//     Are you sure?
//   </div>
//   <div class="modal-footer">
//     <button type="button" data-dismiss="modal" class="btn btn-primary" id="delete">Delete</button>
//     <button type="button" data-dismiss="modal" class="btn">Cancel</button>
//   </div>
// </div>

