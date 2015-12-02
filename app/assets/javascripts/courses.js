// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/


// following code is to prevent course row from expanding when user clicked edit button of each course row at courses index 
function courseIndexRelevant (){
  console.log(".courses.index on page change ");

  function tagJqueryClickCb ( event, tag){
    var $tag = this;
    event.preventDefault();
    event.stopPropagation();
    if (tag === 'a'){
      console.log($($tag).attr('href'));
      window.location.href=$($tag).attr('href');
    } else if (tag == 'option'){
      console.log("option");
    }
  }

  $('.edit-op-btn').click(function(e){
    e.stopPropagation();
  });

  // console.log(window.location.hash);
  // console.log(window.location.href);

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

  $('.delete-link, .confirm-link').click(function (event){
    var atag = this;
    event.preventDefault();
    event.stopPropagation();
    $.ajax({
      url:$(atag).attr("href"),
      success:function (data){
        if ($(atag).hasClass("confirm-link")){
          var $this_li = $( $(atag).attr("data-target") );
          $this_li.find(".label").removeClass().addClass("label label-success").html("Assigned");;
          return;
        }
        window.location.reload();
      },
      error: function (){
        alert("error");
      }
    });
  });
  $('.email-link').click( function onClickEmail (event){
    event.preventDefault();
    var $this = $(this);
    var $this_li = $($this.data("target"));
    var student_full_name = $this_li.find(".ta-full-name-link").text();
    $("#email-form").attr("data-target", $this.data("target"));
    $("#email-form").attr("action", $this.attr("href"));
    $("#email-body").find("textarea[name=email_body]").val(student_full_name + ":\nyou have been assigned TA");
    $("#email-body").find("input[name=student_application_id]").val($this.data("student_application_id"));
    $("#email-shared-editor-modal").modal("show");
  });

  $("#email-form").submit(function onFormSubmission (event){
    event.preventDefault();
    $form = $(this);
    $form.find("button[type=submit]").html('<i class="fa fa-spinner fa-spin"></i>  sending...');
    var text_area_data = $form.find("textarea[name=email_body]").val().replace(/(\r)?\n/, "<br/>");
    $form.find("textarea[name=email_body]").val(text_area_data);
    $.ajax({
        url: $form.attr("action"),
        type: "POST",
        data: $form.serialize(),
        success: function(data, textStatus, jqXHR ){
          if (data.status==="success"){
            $($form.attr("data-target")).find(".label").removeClass().addClass("label label-primary").html("Email Notified");
            $("#email-shared-editor-modal").modal("hide");
            $form.find("button[type=submit]").html("send");
          }
        },
        error: function (jqXHR, textStatus, errorThrown){
          alert("form submission failed");
        }
    });

  });
}

$(document).on("page:change", function (){
  if ($(".courses.index").length > 0){
    courseIndexRelevant();
  }
  if ($(".courses.select_new_ta").length > 0){

    (function (){
      $("input, select,option").click(function (e){
        e.stopPropagation();
      })
      $("a[href=#myModal]").click(function (e){
        console.log("link clicked")
        e.stopPropagation();
        $($(this).data("target")).modal("show")
      });
    })();
  }
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

