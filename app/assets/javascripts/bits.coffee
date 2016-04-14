# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Updates the color of a post heading to a select's value
update_bit_color_to_select = (e) ->
    color = $(this).val()
    $(".bit-heading").css("border-left-color", color)

# Hookups
ready = ->
  $("select#bit_color").on('mouseenter','option',update_bit_color_to_select)
  $("select#bit_color").change(update_bit_color_to_select) # also on changed events, for mobile with no hovers

$(document).ready(ready)
$(document).on('page:load',ready)
