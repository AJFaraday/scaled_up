function init_profile_index() {
  $('#event_profile_check').on('click',function() {
    $.post(
      'event_profiles/'+$(this).val(),
      {"event_profile[active]"=>$(this).val()}
    )
  }
}
