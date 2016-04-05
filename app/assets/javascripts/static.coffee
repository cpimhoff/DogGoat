# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# switches which content is showing based on mouse-over
toggle_hidden_children = (e) ->
  vis = $(this).find(":visible")
  hid = $(this).find(":hidden")
  vis.hide()
  hid.show()

# Hookups
ready = ->
  $(".swear_hover_toggle").hover(toggle_hidden_children)

$(document).ready(ready)
$(document).on('page:load',ready)
