
class Hanafuda.Point
  idcount = 0
  constructor: (x, y) ->
    @set(x || 0, y || 0)
    @cid = 'point-' + (idcount++) if !@cid
  sub: (x, y) ->
    if x instanceof Hanafuda.Point
      y = x.y
      x = x.x
    return new Hanafuda.Point(@x - x, @y - y)
  add: (x, y) ->
    if x instanceof Hanafuda.Point
      y = x.y
      x = x.x
    return new Hanafuda.Point(@x + x, @y + y)
  scl: (factorX, factorY) ->
    if factorX instanceof Hanafuda.Point
      factorY = factorX.y
      factorX = factorX.x
    else if !factorY
      factorY = factorX
    return new Hanafuda.Point(@x * factorX, @y * factorY)
  eql: (x, y) ->
    if x instanceof Hanafuda.Point
      y = x.y
      x = x.x
    return @x is x && @y is y
  max: (x, y) ->
    if x instanceof Hanafuda.Point
      y = x.y
      x = x.x
    @x = x if @x > x
    @y = y if @y > y
  set: (x, y) ->
    if x instanceof Hanafuda.Point
      y = x.y
      x = x.x
    @x = x
    @y = y
  clone: ->
    return new Hanafuda.Point(@x, @y)
  toString: ->
    return 'x: ' + @x + ', y: ' + @y