#= require ./Region

class Hanafuda.Deck extends Hanafuda.Region
  constructor: ->
    @fill = '#000'
    @stroke = '#FFF'
    super 0, 0, Hanafuda.Card.WIDTH, Hanafuda.Card.HEIGHT

  pickup: (index) ->
    index = index || Math.floor(Math.random() * @cards.length)
    card = @cards.splice(index, 1)[0]
    card.setXY(@pos.x, @pos.y)
    return card

  draw: (context) ->
    throw new Hanafuda.UndefinedRenderingContextException(this) if not context?
    if @cards.length > 0
      super(context)
    return

