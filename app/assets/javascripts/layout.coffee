
# Hookups
ready = ->
  $('.flash-block').delay(4000).slideUp()


$(document).ready(ready)
$(document).on('page:load',ready)
