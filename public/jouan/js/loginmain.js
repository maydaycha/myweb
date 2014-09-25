/*call tab in same page*/
$("a[data-tab-destination]").on('click', function() {
        var tab = $(this).attr('data-tab-destination');
        $("#"+tab).click();
    });


 //grabs the hash tag from the url
  var hash = window.location.hash;
  //checks whether or not the hash tag is set
  if (hash != "") {
    //removes all active classes from tabs
    $('#myTab li').each(function() {
      $(this).removeClass('active');
    });
    $('#myTabContent div').each(function() {
      $(this).removeClass('active');
    });
    //this will add the active class on the hashtagged value
    var link = "";
    $('#myTab li').each(function() {
      link = $(this).find('a').attr('href');
      if (link == hash) {
        $(this).addClass('active');
      }
    });
    $('#myTabContent div').each(function() {
      link = $(this).attr('id');
      if ('#'+link == hash) {
        $(this).addClass('active');
      }
    });
  }