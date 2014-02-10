#= require ../geometry/Point
#= require ../exceptions/UndefinedRenderingContextException
class Hanafuda.Rectangle
  idcount = 0
  constructor: (x, y, @width = 0, @height = 0) ->
    @pos = new Hanafuda.Point(x, y)
    @cid = 'rectangle-' + (idcount++) if !@cid

  contains: (x, y) ->
    @pos.x < x && @pos.y < y && @pos.x + @width > x && @pos.y + @height > y

  setXY: (x, y) ->
    @pos.x = x
    @pos.y = y
    return

  setSize: (@width, @height) ->
    return

  invalidate: () ->
    Hanafuda.instance.invalidate()

  draw: (context) ->
    throw new Hanafuda.UndefinedRenderingContextException(this) if not context instanceof CanvasRenderingContext2D
    if @fill or @stroke
      posX = @pos.x
      posY = @pos.y
      context.beginPath()
      context.moveTo(posX, posY);
      context.lineTo(posX + this.width, posY);
      context.lineTo(posX + this.width, posY + this.height);
      context.lineTo(posX, posY + this.height);
      context.lineTo(posX, posY);

      if @fill
        context.fillStyle = @fill
        context.fill()
      if @stroke
        context.strokeStyle = @stroke
        context.stroke()
      context.fillStyle = '#000'
      #context.fillText(@pos.toString() + ', w: ' + @width + ', h: ' + @height, @pos.x - 10, @pos.y - 10)
    return

  toString: () ->
    return "{ x: " + @pos.x + ", y: " + @pos.y + ", width: " + @width + ", height: " + @height + " }"
