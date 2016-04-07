# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Updates the color of a post heading to a select's value
update_post_color_to_select = (e) ->
    color = $(this).val()
    $(".post-heading").css("border-left-color", color)

# Updates the value of a vote-score display after an AJAX request (from an AJAX result)
update_vote_score_display_from_ajax = (status,data,xhr)->
  $(".vote-score-value").text data.vote_score

# Hookups
ready = ->
  $("select#post_color").on('mouseenter','option',update_post_color_to_select)
  $("select#post_color").change(update_post_color_to_select) # also on changed events, for mobile with no hovers

$(document).ready(ready)
$(document).on('page:load',ready)

$(document).on 'ajax:success', 'a.vote-action', update_vote_score_display_from_ajax
