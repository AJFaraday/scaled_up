function init_profile_index() {
  $('.event_profile_check').on('click',function() {
    $.ajax({
      type: 'PATCH',
      url: 'event_profiles/'+$(this).val(),
      data: {"event_profile[active]": $(this).val()},
      dataType: 'script'
    });
  });
}

$(document).ready(function() {
  init_profile_index();
});

$(document).on('page:load',function() {
  init_profile_index();
});
