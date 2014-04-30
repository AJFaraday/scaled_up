function init_keyboard() {
  $('.note.active').on('click', function() {
    if ($(this).hasClass("selected")) {
      $(this).removeClass("selected");
    } else {
      $(this).addClass("selected");
      midi_note = $(this).data('value');
      current_val = $("#event_midi_notes").val();
      $("#event_midi_notes").val(current_val+','+midi_note);
    } 
  });
}

function init_form(){
  $('#event_event_profile_id').on('change', function(){renew_form()});
}

function renew_form() {
  $.post(
    '/events/renew_form',
    $('#new_event').serialize()
  )
}

$(document).ready(function(){

  init_keyboard();
  init_form();

});
