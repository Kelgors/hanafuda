#= require ./Region
class Hanafuda.Hand extends Hanafuda.Region
  PADDING_RIGHT = 10
  constructor: (@name, x, y, w, h) ->
    super x, y, w, h
    @cards = new Hanafuda.List()
    @gain = new Hanafuda.List()

    @stroke = '#00FF00'
    @selected = null
    @isPlayerHand = false

  size: ->
    return @cards.length

  addCard: (card) ->
    card.stroke = '#000'
    @cards.push(card)
    card.moveTo(@getCardPositionByIndex(@cards.length))
    card.setOwner(this)
    return

  getCardPositionByIndex: (index) ->
    return new Hanafuda.Point(@pos.x + 20 + index * (Hanafuda.Card.WIDTH + PADDING_RIGHT), @pos.y + @height / 2 - Hanafuda.Card.HEIGHT / 2)

  getCardIndex: (card) ->
    return @cards.indexOf(card)

  getLargerCollection: ->
    return if @cards.length > @gain.length then @cards else @gain

  getThinnerCollection: ->
    return if @cards.length > @gain.length then @gain else @cards

  getChildAt: (posX, posY) ->
    larger = @getLargerCollection()
    thinner = @getThinnerCollection()
    largeLen = larger.length
    thinLen = thinner.length
    index = 0
    while index < largeLen
      return larger[index] if larger[index].contains(posX, posY)
      if index < thinLen
        return thinner[index] if thinner[index].contains(posX, posY)
      index += 1
    return this
  draw: (context) ->
    throw new Hanafuda.UndefinedRenderingContextException(this) if not context?
    larger = @getLargerCollection()
    thinner = @getThinnerCollection()
    largeLen = larger.length
    thinLen = thinner.length
    index = 0
    while index < largeLen
      larger[index].draw(context)
      thinner[index].draw(context) if index < thinLen
      index += 1
    super if Hanafuda.DEBUG

  clear: ->
    @cards.length = 0
    @gain.length = 0
    return

  validPositionY = 100
  validateCombo: (card1, card2, callback) ->
    @validateCard(card1)
    @validateCard(card2, callback)
    return
  validateCard: (card, callback) ->
    posY = @pos.y + @height / 2 + Hanafuda.Card.HEIGHT * 1.5
    switch card.type
      when TYPE.COMMON
        posX = 10
        break
      when TYPE.RED_RIBBON || TYPE.BLUE_RIBBON || TYPE.POETRY_RIBBON
        posX = 100
        break
      when TYPE.ANIMAL
        posX = 200
        break
      when TYPE.SPECIAL
        posX = 300
        break
    posX += @gain.countWhere(type: card.type) * (Hanafuda.Card.WIDTH - PADDING_RIGHT)
    @cards.remove(card)
    @gain.push(card)
    card.setOwner(this)
    if callback
      card.moveTo(posX, posY, 300).onComplete(callback)
    else
      card.moveTo(posX, posY, 300)
    return
