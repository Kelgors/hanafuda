#= require ../geometry/Point
#= require ../exceptions/UndefinedRenderingContextException
class Hanafuda.Rectangle
  idcount = 0
  constructor: (x, y, @width = 0, @height = 0) ->
    @pos = new Hanafuda.Point(x, y)
    @cid = 'rectangle-' + (idcount++) if !@cid
  contains: (x, y) ->
    return @pos.x < x && @pos.y < y && @pos.x + @width > x && @pos.y + @height > y
  setXY: (x, y) ->
    @pos.x = x
    @pos.y = y
    return
  setSize: (@width, @height) ->
   clone: ->
    return new Hanafuda.Rectangle(@pos.x, @pos.y, @width, @height)
   toString: ->
    return "{ x: " + @pos.x + ", y: " + @pos.y + ", width: " + @width + ", height: " + @height + " }"
