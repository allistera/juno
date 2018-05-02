document.addEventListener("turbolinks:load", function() {

  $('.nav-tabs li a').click(function(){
    var tab_id = $(this).attr('data-tab');
    

    $('.nav-tabs li a').removeClass('active');
    $('.tab-content').addClass('hidden');

    $(this).addClass('active');
    $("#" + tab_id).removeClass('hidden');
  });

  $( "#chart-scope" ).change(function() {
      var siteID = $('#chart-scope').data('id');
      new Chartkick.LineChart("chart-1", "/sites/" + siteID + "/checks?range=" + this.value, {});
  });

});
