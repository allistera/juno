document.addEventListener("turbolinks:load", function() {
  $('#success_status').click(function(){
    if ($(this).is(':checked'))
    {
      $('#custom_status_value').attr("disabled", "disabled");
      $('#custom_status_value').val('');
    }
  });

  $('#custom_status').click(function(){
    if ($(this).is(':checked'))
    {
      $('#custom_status_value').removeAttr("disabled");
    }
  });
});
