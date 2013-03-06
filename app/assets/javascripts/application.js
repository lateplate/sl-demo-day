// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {

  $("#nag-form").validate();
  console.log("validate ran");

  $(window).keydown(function(event){
    if( (event.keyCode == 13) ) {
      event.preventDefault();
      return false;
    }
  });

  // Date picker
  $(function() {
    $("#when").datepicker({ dateFormat: "yy-mm-dd" });
  });

  // Type ahead
  $(function() {
    var allFriends = $.map(fbFriendData, function (i) {
      return {
        label: i.name,
        value: i.id
      };
    });

    $("#who").autocomplete({
      source: allFriends,
      appendTo: $("#friend-list"),
      focus: function( event, ui ) {
        $( "#who" ).val( ui.item.label );
        return false;
      },
      select: function (event, ui) {
          $("#who").val(ui.item.label);
          $("#lendee_uid").val(ui.item.value);
          return false;
      },
      position: { of: "#friend-list", at: "left top" },
      change: function (event, ui) {
        if (ui.item == null || ui.item == undefined) {
          clearWho();
        }


      } 
    }).keyup(function (e) { // Dismiss the typeahead dropdown when hitting enter
          if(e.which === 13) {
              $(".ui-menu-item").hide();
          }
      });;
  });

  function clearWho() {
    $("#who").val("");
    $("#lendee_uid").val("");
  }

  // Opens/closes the preview email on detail.html
  // $('#send-reminder').on('click', function(event){
  //   $('.inactive').slideToggle('active');
  // });

  // $('#cancel-reminder').on('click', function(event){
  //   $('.inactive').slideToggle('active');
  // });
});

