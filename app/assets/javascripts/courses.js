// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/


// following code is to prevent course row from expanding when user clicked edit button of each course row at courses index 
$(document).ready(function (){
  console.log("course. js onReady()");

  function tagJqueryClickCb ( event, tag){
    var $tag = this;
    event.preventDefault();
    event.stopPropagation();
    if (tag == 'a'){
      window.location.href=$($tag).attr('href');
    } else if (tag == 'option'){
      console.log("option");
    }
  }

  $('.edit-op-btn').click(function(e){
    e.preventDefault();
    e.stopPropagation();
    window.open($(this).attr('href'));
  });

  console.log(window.location.hash)
  console.log(window.location.href)

  if (window.location.hash){
    var anchor = window.location.hash;
    console.log(anchor);
    if(anchor.match(/^#heading\d+$/)){
      anchor = anchor.replace("heading","collapse");
      console.log(anchor);  // #heading1
      if (!$(anchor).hasClass('in')) {
        console.log("here");  
        $(anchor).collapse('toggle');
      }
      else {
        $(anchor).collapse('toggle');
      }
    }

  }
  // Bowei: I understand this piece of code is weired, but I have to close this accordian before go to new link,
  // I have to update the  Bootstrap event manager that this accordian has been closed, 
  // otherwise, if use click back to courses, the accordian cannot be expanded, due to bootstrap event manager will
  // wrongly believe that the accordian has already been expanded.

  $('a.add-new-ta').click(function(event){
    var atag = this;
    event.preventDefault();
    event.stopPropagation();
    var $target = $(this).attr("data-toggle-target");
    $($target).collapse("hide");
    setTimeout(function (){
      window.location.href= $(atag).attr('href');
    },500);

  });

  
  


  //http://railsapps.github.io/rails-javascript-include-external.html
  // Basically ruby on rails originally does not allow page-specific javascript ??!
  // since ruby on rails adopts a very strange javascript importing mechanism(according the first three lines of comments of this file),
  // following code is related with select new TA

  $('a.back-to-class-list').click(tagJqueryClickCb);

  $('input[type=checkbox], select').click(function (e){
    e.stopPropagation();
  });
  $('a[href=#myModal]').click( function (e){
    e.stopPropagation();
    $($(this).attr('data-target')).modal('show');
  });


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

