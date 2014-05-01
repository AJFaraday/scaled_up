function next_note_index() {
  var indexes = $.map($('#midi_fields :input'), function(n, i){
    var ind = /\[(.?)\]/g.exec($(n).attr('name'))[1];
    return parseInt(ind,10);
  })
  if (indexes.length > 0) {
    var max_index = Math.max.apply(null,indexes);
    var index = (max_index + 1);
  } else {
    var index = 0 ;
  }
  return index;
}

function add_midi_note_field(midi_note) {
  $('#midi_fields').append(
    '<input type="hidden" name="event[midi_notes]['+
    next_note_index()+
    ']" value="'+midi_note+'">');
}

function remove_midi_note_field(midi_note) {
  $('input[value="'+midi_note+'"]').remove();
}

function init_keyboard() {
  $('.note.active').on('click', function() {
    var midi_note = $(this).data('value');
    if ($(this).hasClass("selected")) {
      $(this).removeClass("selected");
      remove_midi_note_field(midi_note);
    } else {
      $(this).addClass("selected");
      add_midi_note_field(midi_note);
    } 
    submit_if_complete()
  });
}

function submit_if_complete() {
  var req_notes = parseInt($('#note_requirement').val(),10);
  if ($('#midi_fields :input').length >= req_notes) {
    $('#waiting_modal').modal('show');
    $('#processing_message').show();
    $('#waiting_message').hide();
    $('#waiting_countdown').hide();
    
    $.ajax({
      url: '/events',
      type: 'POST',
      data: $('#new_event').serialize(),
      dataType: 'script'
    });
  }
} 

function init_form(){
  $('#event_event_profile_id').on('change', function(){renew_form()});
  $('#event_source').keyup(function(){show_form_if_source()});
  $(window).keydown(function(event){
    if(event.keyCode == 13) {
      event.preventDefault();
      return false;
    }
  });
  show_form_if_source();
  init_modal();
}

function show_form_if_source(){
  if($('#event_source').val().length > 3) {
    $('#main_form').show();
  } else {
    $('#main_form').hide();
  }
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

function init_modal() {
  $('#waiting_modal').modal({
    keyboard: false,
    show: false,
    backdrop: 'static'
  })
}
