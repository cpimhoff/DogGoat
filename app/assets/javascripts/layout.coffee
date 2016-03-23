
# Hookups
ready = ->
  $('.flash_block').delay(4000).slideUp()


$(document).ready(ready)
$(document).on('page:load',ready)
