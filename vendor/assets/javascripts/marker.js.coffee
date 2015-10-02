class Marker
  ##*
  # Require an instance of Gmaps or GMaps to work.
  #
  # @constructor
  # @param {string} el - the element to bind the map to.
  ##
  constructor: (@el = "#map") ->
    ##*
    # @property {object} el
    ##
    return unless window.Gmaps or window.GMaps

    ##*
    # @property {object} map - instance of map canvas
    ##
    @map = window.Gmaps or window.GMaps
    @

  ##*
  # Set marker latitude to update position.
  #
  # @method setLatitude
  # @param {number} lat
  ##
  setLatitude: (@lat) ->
    @latValue = $(@lat).val()

  ##*
  # Set marker longitude to update position.
  #
  # @method setLongitude
  # @param {number} lng
  ##
  setLongitude: (@lng) ->
    @lngValue = $(@lng).val()

  ##*
  # Update marker position.
  #
  # @method updatePosition
  # @param {object} e - event
  # @return {object} marker
  ##
  updatePosition: (e) ->
    return unless e?
    return unless @lat and @lng
    e.preventDefault
    @marker =
      lat: e.latLng.lat()
      lng: e.latLng.lng()
    $(@lat).val(@marker.lat)
    $(@lng).val(@marker.lng)
    @clear()
    return @marker

  ##*
  # Add a marker to the map.
  #
  # @method add
  # @param {object} marker
  ##
  add: (@marker) ->
    ##*
    # @property {object} marker
    # @property {number} marker.lat - positive or negative, can be float
    # @property {number} marker.lng - positive or negative, can be float
    ##
    if not "lat" in @marker
      return console.error "Error: missing latitude - param.lat"
    if not "lng" in @marker
      return console.error "Error: missing longitude - param.lng"
    @show(@marker.title)

  ##*
  # Clear the map from all this markers.
  # @method clear
  ##
  clear: ->
    @target.removeMarkers()

  ##*
  # Render a marker.
  #
  # @method show
  ##
  show: (title = "") ->
    @target.addMarker({
      lat: @marker.lat,
      lng: @marker.lng,
      title: title,
      infoWindow: content: title
    })

  ##*
  # Set camera.
  # @method render
  ##
  render: (position) ->
    return unless position
    ##*
    # @property {object} target - marker on the map
    ##
    @target = new @map({
      el: @el,
      lat: position.lat,
      lng: position.lng
    })

window.Marker = Marker
