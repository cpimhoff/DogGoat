# Hookups
ready = ->
  $(".on-load-fade-in").hide().fadeIn(1000)
  $(".on-load-fade-drop-from-above").animate({
    opacity: 1.0,
    top: 0
  }, 800)

$(document).ready(ready)
$(document).on('page:load',ready)
