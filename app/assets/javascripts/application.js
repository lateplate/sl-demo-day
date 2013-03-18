//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function ()
{

  // ****************************************************************************
  // FLASH MESSAGES
  // ****************************************************************************
  $("#close_flash").on('click', function ()
  {
    $(".flash-message").hide();
  });
  $(".flash-message").delay(4000).fadeOut();

  // ****************************************************************************
  // VALIDATION
  // ****************************************************************************
  $("#nag-form").validate();
  $("input, textarea").placeholder(); // placeholder helper text for older browsers

  // ****************************************************************************
  // DISABLE KEYS
  // ****************************************************************************
  // disables enter key to prevent accidental form inputs
  $(window).keydown(function (event)
  {
    if ((event.keyCode == 13))
    {
      event.preventDefault();
      return false;
    }
  });

  // ****************************************************************************
  // DATE PICKER
  // ****************************************************************************
  $(function ()
  {
    $("#when").datepicker(
    {
      dateFormat: "yy-mm-dd"
    });
  });

  // ****************************************************************************
  // FRIEND AUTOCOMPLETE / TYPE AHEAD
  // ****************************************************************************
  $(function ()
  {

    // parse the json from Rails
    var allFriends = $.map(fbFriendData, function (i)
    {
      return {
        label: i.name,
        value: i.id
      };
    });

    // finde the right form field
    $("#who").autocomplete(
    {
      source: allFriends,
      minLength: 2,
      // starts when user enters two characters
      appendTo: $("#friend-list"),
      // div to show the list in
      focus: function (event, ui) // when friend hovered, show value in input field
      {
        $("#who").val(ui.item.label);
        return false;
      },
      select: function (event, ui) // when friend selected, show value in input field and hidden lendee id field
      {
        $("#who").val(ui.item.label);
        $("#lendee_uid").val(ui.item.value);
        return false;
      },
      position: { // positions the div
        of: "#friend-list",
        at: "left top"
      },
      change: function (event, ui) // if they started typing something random that didn't match a friend, we clear the fields when they leave it
      {
        if (ui.item == null || ui.item == undefined)
        {
          clearWho();
        }
      }
    }).keyup(

    function (e)
    { // Dismiss the typeahead dropdown when hitting enter
      if (e.which === 13)
      {
        $(".ui-menu-item").hide();
      }
    })

    .keydown(

    function (e)
    { // Using Backspace or delete clears the entire friend's name, no partial deletes
      if (e.which === 8 || e.which === 46)
      {
        clearWho();
      }
    });
  });

  // helper to clear the values from the "who" and hidden lendee fields

  function clearWho()
  {
    $("#who").val("");
    $("#lendee_uid").val("");
  }

  // ****************************************************************************
  // NAVIGATION
  // ****************************************************************************
  $("#menu-icon").on("click", function ()
  {
    $("#nav").slideToggle();
    $(this).toggleClass("active");
  });

  // ****************************************************************************
  // EMAIL PREVIEW
  // ****************************************************************************
  $('#show-message-preview').on('click', function (event)
  {
    $('.reminder-form').slideToggle();
  });

  $('#cancel-reminder').on('click', function (event)
  {
    $('.reminder-form').slideToggle();
  });
});
