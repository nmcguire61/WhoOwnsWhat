// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {

  function updateElement($element, content) {
    if ($element.text() != content) {
      $element.text(content);

      $element.addClass('flash');

      setTimeout( function() {
        $element.removeClass('flash');
      }, 1000);
    }
  };


  $('#all_users').on('submit', function (e){
    e.preventDefault();

    var steamidp1  = $('#steamidp1').val();
    //var url = '/steam_fred/'//?steamidp1=' + steamidp1;
    //var url = 'first_player/?steamidp1=' + steamidp1;
    var url = 'first_player/'
    console.log(url);

    console.log('Pressed the button');

    $.ajax({
      url: url,
      type: 'GET',
      data: {steamidp1 : steamidp1},
      // dataType: "json",
      success: function (data.summary.profile['steamid']) {
        console.log(steamidp1);
        console.log(data);

      },
      complete:function() {
        console.log("complete");
      }
    });

    /*$.ajax({
      url: url,
      type: 'POST',
      data: {"steamidp1" : $(this).val()},
      dataType: "json",
      success: function(data) {
        console.log(steamidp1);
      },
    });*/
  });


});


$(document).ready(function() {
  $.get('/fred').success(function(data){
    $('#stuff').append(data);
  })
});

$(function() {
  $.get('/steam_fred').success(function(data){
    $('#steam_stuff').append(data);
  })
});

// $(function() {
//   $.get('/library_names').success(function(data){
//     $('#library_names').append(data);
//   })
// });


$(function() {
  $.get('/game_name').success(function(data){
    $('#game_name').append(data);
  })
});

$(function() {
  $.get('/game_playtime').success(function(data){
    $('#game_playtime').append(data);
  })
});

$(function() {
  $.get('/game_picture').success(function(data){
    $('#game_pic').append(data);
  })
});

$(function() {
  $.get('/show_library').success(function(data){
    $('#show_library').append(data);
  })
});



