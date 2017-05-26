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

  $('.tabs ul li').click(function(){
    var tab_id = $(this).attr('data-tab');

    $('.tabs ul li').removeClass('is-active');
    $('.tab-content').addClass('hidden');

    $(this).addClass('is-active');
    $("#" + tab_id).removeClass('hidden');
  })

});
