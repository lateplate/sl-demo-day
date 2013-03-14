//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
  $("#close_flash").on('click', function() {
    $(".flash-message").fadeOut(200);
  });

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
      minLength: 2,
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

  // Dan: temporarily commented out while I work on the submit through checkbox
  // $('.checkbox:not(.checked)').on('click', function(event){
  //   $(this).parent().slideUp('slow', 'linear');
  //   $(this).toggleClass('checked');
  // });


/* prepend menu icon */
  // $('#nav-wrap').append('<div id="menu-icon">Menu</div>');

  /* toggle nav */
  $("#menu-icon").on("click", function(){
    $("#nav").slideToggle();
    $(this).toggleClass("active");
  });

  // Opens/closes the preview email on detail.html
  $('#show-message-preview').on('click', function(event){
    $('.reminder-form').slideToggle();
  });

  $('#cancel-reminder').on('click', function(event){
    $('.reminder-form').slideToggle();
  });
});

