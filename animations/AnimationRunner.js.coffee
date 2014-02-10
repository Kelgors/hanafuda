#= require ../geometry/Point
class Hanafuda.AnimationRunner extends Array
  constructor: ->
    @current = null
    super 0
   dispose: ->
    @length = 0
    @current = null
    return
  add: (animation) ->
    @push(animation)
    return animation
  update: (delta) ->
    index = 0
    size = @length
    while index < size
      current = this[index++]
      current.update(delta)
      if current.isComplete()
        current.onComplete()
        current.dispose()
        @splice(--index, 1)
        size--
    return