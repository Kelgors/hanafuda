#= require ../geometry/Rectangle
class Hanafuda.Region extends Hanafuda.Rectangle
  constructor: ->
    @events = {}
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