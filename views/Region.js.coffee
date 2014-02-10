#= require ../geometry/Rectangle
class Hanafuda.Region extends Hanafuda.Rectangle
  idcount = 0
  constructor: ->
    @events = {}
    @cid = 'region-' + (idcount++) if !@cid
    super
  on: (name, callback, context) ->
    throw new Hanafuda.ArgumentException(this) if not name or not callback
    @events[name] = new Hanafuda.List if not @events[name]
    @events[name].push(callback: callback, context: context)
    return this
  off: (name, callback, context) ->
    return if not @events[name]
    condition = {}
    condition.name = name if name
    condition.callback = callback if callback
    condition.context = context if context
    @events[name].remove.apply @events[name], @events[name].where(condition)
    return this
  trigger: (name, eventArg) ->
    return if not @events[name]
    index = 0
    len = @events[name].length
    eventArg.type = name
    while index < len
      event = @events[name][index++]
      event.callback.call(event.context || this, eventArg)
    return
   invalidate: ->
    Hanafuda.instance.invalidate()
    return
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
    return