twttr_events_bound = false

bindTwitterEventHandlers = ->
  $(document).on 'turbolinks:load', renderTweetButtons
  twttr_events_bound = true

renderTweetButtons = ->
  $('.twitter-share-button').each ->
    button = $(this)
    button.attr('data-url', document.location.href) unless button.data('url')?
    button.attr('data-text', document.title) unless button.data('text')?
  twttr.widgets.load()

loadTwitterSDK = ->
  $.getScript("//platform.twitter.com/widgets.js")


ready = ->
  loadTwitterSDK()
  bindTwitterEventHandlers() unless twttr_events_bound

$(document).on("turbolinks:load", ready)
