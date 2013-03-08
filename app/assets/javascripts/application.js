// DO NOT ADD RAILS VERSIONS OF JS FILES IN HERE. WE WILL MINIFY INTO ONE FILE EVENTUALLY. WE WANT TO HIT THE GOOGLE CDNS, NOT LOCAL FILES
// rails needs these files.... rails does certain things under the hood with these javascript files to help us. They let us submit and receive form data in a nice way and they allow us to submit DELETE and PUT http requests for RESTful routing purposes. Any link that uses a DELETE verb on our site will not process correctly without these.
//= require jquery
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

  // Dan: temporarily commented out while I work on the submit through checkbox
  // $('.checkbox:not(.checked)').on('click', function(event){
  //   $(this).parent().slideUp('slow', 'linear');
  //   $(this).toggleClass('checked');
  // });


/* prepend menu icon */
  $('#nav-wrap').append('<div id="menu-icon">Menu</div>');

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

