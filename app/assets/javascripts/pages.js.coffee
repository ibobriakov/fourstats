$(document).ready ->
  $("#paginate  a.next_page").live "click", (n) ->
    $('#paginate').html("<div class='span3 offset4'><img src='/img/ajax-loader.gif' /></span>");
    $.get @href,
      action_key: "pag"
    , null, "script"
    n.preventDefault()

$(document).ready ->
  $("#go").live "click", (n) ->
    $('#main_content').html("<div class='span2 offset5'><img src='/img/ajax-loader-y.gif' /></span>");