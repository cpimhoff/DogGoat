# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Updates the color of a post heading to a select's value
update_to_meet_blank = (e) ->
    value = $(this).val()
    $("#new_member_name_fill_in").html(value)

# Hookups
ready = ->
  $("input#invite_first_name").keyup(update_to_meet_blank)

$(document).ready(ready)
$(document).on('page:load',ready)
