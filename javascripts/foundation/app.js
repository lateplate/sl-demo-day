// *****
// FACEBOOK
// *****

// Facebook SDK asynchronous loading
// (function(d, debug){
//   var js, id = 'facebook-jssdk', ref = d.getElementsByTagName('script')[0];
//   if (d.getElementById(id)) {return;}
//   js = d.createElement('script'); js.id = id; js.async = true;
//   js.src = "//connect.facebook.net/en_US/all" + (debug ? "/debug" : "") + ".js";
//   ref.parentNode.insertBefore(js, ref);
// }(document, /*debug*/ false));

// // Wait until the FB SDK is loaded, then init the FB objects.
// window.fbAsyncInit = function() {
//   FB.init({
//     appId      : '134969066680167', // App ID from the App Dashboard
//     channelUrl : '//localhost/github/sl-demo-day/channel.html', // Channel File for x-domain communication
//     status     : true, // check the login status upon init?
//     cookie     : true, // set sessions cookies to allow your server to access the session?
//     xfbml      : true  // parse XFBML tags on this page?
//   });

//   FB.api('/me', function(response) {
//     console.log('Your name is ' + response.name);
//   });
// };





// *****
// BASE CREATED BY FOUNDATION
// *****

;(function ($, window, undefined) {
  'use strict';

  var $doc = $(document),
      Modernizr = window.Modernizr;

  $(document).ready(function() {
    $.fn.foundationAlerts           ? $doc.foundationAlerts() : null;
    $.fn.foundationButtons          ? $doc.foundationButtons() : null;
    $.fn.foundationAccordion        ? $doc.foundationAccordion() : null;
    $.fn.foundationNavigation       ? $doc.foundationNavigation() : null;
    $.fn.foundationTopBar           ? $doc.foundationTopBar() : null;
    $.fn.foundationCustomForms      ? $doc.foundationCustomForms() : null;
    $.fn.foundationMediaQueryViewer ? $doc.foundationMediaQueryViewer() : null;
    $.fn.foundationTabs             ? $doc.foundationTabs({callback : $.foundation.customForms.appendCustomMarkup}) : null;
    $.fn.foundationTooltips         ? $doc.foundationTooltips() : null;
    $.fn.foundationMagellan         ? $doc.foundationMagellan() : null;
    $.fn.foundationClearing         ? $doc.foundationClearing() : null;

    $.fn.placeholder                ? $('input, textarea').placeholder() : null;
  });

  // UNCOMMENT THE LINE YOU WANT BELOW IF YOU WANT IE8 SUPPORT AND ARE USING .block-grids
  // $('.block-grid.two-up>li:nth-child(2n+1)').css({clear: 'both'});
  // $('.block-grid.three-up>li:nth-child(3n+1)').css({clear: 'both'});
  // $('.block-grid.four-up>li:nth-child(4n+1)').css({clear: 'both'});
  // $('.block-grid.five-up>li:nth-child(5n+1)').css({clear: 'both'});

  // Hide address bar on mobile devices (except if #hash present, so we don't mess up deep linking).
  if (Modernizr.touch && !window.location.hash) {
    $(window).load(function () {
      setTimeout(function () {
        // At load, if user hasn't scrolled more than 20px or so...
  			if( $(window).scrollTop() < 20 ) {
          window.scrollTo(0, 1);
        }
      }, 0);
    });
  }

})(jQuery, this);





// *****
// CUSTOM CODE
// *****

// Date picker
$(function() {
  $("#when").datepicker(); 
});

// Type ahead
$(function() {
  var allFriends = [
    {
      value: "Karen Wei",
      email: "karen@nagapp.com",
      picture: "karen.jpg"
    },
    { 
      value: "Dan Kim",
      email: "dan@nagapp.com",
      picture: "dan.jpg"
    },
    { 
      value: "Will Piers",
      email: "will@nagapp.com",
      picture: "will.jpg"
    },
    {
      value: "Ankur Patel",
      email: "emailankur@gmail.com",
      picture: "ankur.jpg"
    },
    {
      value: "Arif Poonawala",
      email: "arif.poonawala@gmail.com",
      picture: "arif.jpg"
    },
    {
      value: "Pedro Carmo",
      email: "1pedrocarmo@gmail.com",
      picture: "pedro.jpg"
    },
  ];

  $("#who").autocomplete({
    source: allFriends,
    appendTo: $("#friend-list"),
    focus: function( event, ui ) {
      $( "#who" ).val( ui.item.value );
      return false;
    },
    position: { of: "#friend-list", at: "left top" }
  }).keyup(function (e) { // Dismiss the typeahead dropdown when hitting enter
        if(e.which === 13) {
            $(".ui-menu-item").hide();
        }            
    });;
});

// Opens/closes the preview email on detail.html
$('#send-reminder').on('click', function(event){
  $('.inactive').slideToggle('active');
});

$('#cancel-reminder').on('click', function(event){
  $('.inactive').slideToggle('active');
});