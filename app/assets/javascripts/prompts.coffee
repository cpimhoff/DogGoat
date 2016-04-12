# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Updates the color of a post heading to a select's value
update_prompt_color_to_select = (e) ->
    color = $(this).val()
    $(".prompt-heading").css("border-left-color", color)

# Updates the value of a score display after an AJAX request (from an AJAX result)
on_recieve_new_riff = (status,data,xhr)->
  $("#riff_content").val('')
  $(".riff-list").append("<div class='riff-show'>
    <div class='riff-content'>
      #{data.new_riff_content}
    </div>
    <div class='riff-author'>
      #{data.new_riff_author}
    </div>
  </div>")

# Hookups
ready = ->
  $("select#prompt_color").on('mouseenter','option',update_prompt_color_to_select)
  $("select#prompt_color").change(update_prompt_color_to_select) # also on changed events, for mobile with no hovers

$(document).ready(ready)
$(document).on('page:load',ready)

$(document).on 'ajax:success', on_recieve_new_riff
