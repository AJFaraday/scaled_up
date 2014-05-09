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

function init_samples() {
  $('.sample_button').on('click', function() {
    var sample_id = $(this).data('value');
    $('#event_sample_id').val(sample_id);

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
  $('input[name="event[event_profile_id]"]').on('change', function(){renew_form()});
  $('#event_source').keyup(function(){show_form_if_source()});
  $(window).keydown(function(event){
    if(event.keyCode == 13) {
      event.preventDefault();
      return false;
    }
  });
  show_form_if_source();
  init_modal();
  init_keyboard();
  init_samples();
}

function show_form_if_source(){
  if($('#event_source').val() && $('#event_source').val().length >= 3) {
    $('#main_form').show();
    $('#no_options_message').hide();
  } else {
    $('#main_form').hide();
    $('#no_options_message').hide();
  }
  if($('.btn-group#profiles').length == 1 & $.trim($('.btn-group#profiles').html()) == "") {
    $('#main_form').hide();
    $('#no_options_message').show();
    setTimeout(
      function(){
        renew_form();
        if($.trim($('.btn-group#profiles').html()) != ""){
          init_form();
        }
      },
      2000
    );
  }
}


function renew_form() {
  $.post(
    '/events/renew_form',
    $('#new_event').serialize()
  )
}

$(document).ready(function(){
  init_form();
});

$(document).on('page:load',function() {
  init_form();
});

function init_modal() {
  $('#waiting_modal').modal({
    keyboard: false,
    show: false,
    backdrop: 'static'
  })
}
