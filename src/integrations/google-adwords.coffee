Integration = require '../integration'

module.exports = class GoogleAdWords extends Integration
  type: 'script'
  src: '//www.googleadservices.com/pagead/conversion_async.js'

  constructor: (@pixels = {}) ->

  init: ->
    window.google_trackConversion = ->

  page: (category, name, props, opts, cb = ->) ->
    name = category if arguments.length == 1

    return unless (pixel = @pixels[name])?

    @log 'GoogleAdWords.page', arguments

    google_trackConversion
      google_conversion_id:    pixel.id
      google_custom_params:    props
      google_remarketing_only: pixel.remarketing ? false

    cb null

  track: (event, props, opts, cb = ->) ->
    return unless (pixel = @pixels[event])?

    @log 'GoogleAdWords.track', arguments

    google_trackConversion
      google_conversion_id:       pixel.id
      google_custom_params:       props
      google_conversion_language: 'en'
      google_conversion_format:   '3'
      google_conversion_color:    'ffffff'
      google_conversion_label:    event
      google_conversion_value:    props.total
      google_remarketing_only:    false

    cb null
