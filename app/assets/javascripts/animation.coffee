
childSequenceAppearAnimation = ->
  totalDuration = 300
  childCount = $(".on-load-sequence-fade-in-container").children(".animation-child").size()
  $(".on-load-sequence-fade-in-container").children(".animation-child").each((index) ->
    $(this).delay(index*(totalDuration/childCount)).animate({
        opacity: 1.0
        left: 0
      }, totalDuration))

# Hookups
ready = ->
  $(".on-load-fade-in").hide().fadeIn(1000)
  $(".on-load-fade-drop-from-above").animate({
    opacity: 1.0
    top: 0
  }, 500)
  childSequenceAppearAnimation()

$(document).ready(ready)
$(document).on('page:load',ready)
