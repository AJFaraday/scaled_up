function init_scale_select() {
  $('.scale_select').on('change', function(){
    var id = $('select#id').val();
    var offset = $('select#offset').val();
  
  
    $.ajax({
      type: 'POST',
      url: ("/scales/"+id+"/set_current"),
      data: {offset: offset},
      dataType: 'script'
    }); 
  });
}
