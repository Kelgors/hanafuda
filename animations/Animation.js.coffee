#= require ../geometry/Point
class Hanafuda.Animation
  constructor: (@instance, @duration, x, y, @type) ->
    @finalpos = new Hanafuda.Point(x, y)
    @beginpos = @instance.pos.clone()
    @deltapos = @finalpos.sub(@beginpos)
    @xup = @beginpos.x < @finalpos.x
    @yup = @beginpos.y < @finalpos.y
    @instance.animations.push(this)
    @isgoingback = false

  onBegin: ->
    @instance.isAnimating = true
    return

  onComplete: (callback) ->
    if callback
      @onAnimationComplete = callback
      return
    @instance.isAnimating = false
    @instance.animations.remove(this)
    do @onAnimationComplete if @onAnimationComplete
    return

  update: (delta) ->
    do @onBegin if @totaltime is delta
    @instance.invalidate()
    return

  isComplete: ->
    return @instance.pos.eql(@finalpos)

  dispose: ->
    @onAnimationComplete = @finalpos = @beginpos = @deltaPos = @instance = null
    return

  goback: ->
    @constructor.call(this, @instance, @duration / 2, @beginpos.x, @beginpos.y, @type)
    @isgoingback = !@isgoingback
