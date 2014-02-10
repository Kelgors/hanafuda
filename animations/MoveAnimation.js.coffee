#= require ./Animation
class Hanafuda.MoveAnimation extends Hanafuda.Animation
  update: (delta) ->
    @totaltime += delta
    newpos = @instance.pos.add(@deltapos.scl(delta / @duration))
    if @xup
      newpos.x = @finalpos.x if newpos.x > @finalpos.x
    else
      newpos.x = @finalpos.x if newpos.x < @finalpos.x
    if @yup
      newpos.y = @finalpos.y if newpos.y > @finalpos.y
    else
      newpos.y = @finalpos.y if newpos.y < @finalpos.y
    @instance.pos.set(newpos)
    super delta
    return
