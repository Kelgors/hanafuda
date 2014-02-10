#= require ./Region
class Hanafuda.Board extends Hanafuda.Region
  constructor: (@name, @deck, x, y, width, height) ->
    super x, y, width, height
    @pile = new Hanafuda.List
    @cards = new Hanafuda.List
    paddingY = 10
    paddingX = 10
    @stroke = '#FF0000'
    @selected = null

  size: ->
    @cards.length

  findEmptySpace: ->
    index = 0
    len = @cards.length
    while index < len
      return index if @cards[index] is null or typeof @cards[index] is 'undefined'
      index += 1
    return @cards.length

  addCard: (card) ->
    index = @findEmptySpace()
    if index % 2 is 0
      posY = @pos.y + @height / 2 - 10 - Hanafuda.Card.HEIGHT
    else
      posY = @pos.y + @height / 2 + 10
    posX = @deck.pos.x  + @deck.width + 20 + (index - (index % 2)) / 2 * (Hanafuda.Card.WIDTH + 10)
    card.moveTo(posX, posY)
    card.setOwner(this)
    card.stroke = '#000'
    @cards.set(index, card)
    return index

  clear: (deck) ->
    @cards.length = @pile.length = 0
    pos = @deck.pos.clone()
    @deck.constructor.call(@deck)
    @deck.pos.set(pos)
    @pile.push.apply(@pile, @deck.cards)
    @deck.cards.each @clearIterator.bind(this)
    return
  clearIterator: (index, card) ->
    card.owner = this
    @pile.push(card)

  draw: (context) ->
    throw new Hanafuda.UndefinedRenderingContextException(this) if not context?
    index = 0
    len = @cards.length
    while index < len
      @cards[index++].draw(context)
    @deck.draw(context)
    super if Hanafuda.DEBUG
    return

  getChildAt: (posX, posY) ->
    return @deck if @deck.contains(posX, posY)
    index = 0
    len = @cards.length
    while index < len
      return @cards[index] if @cards[index].contains(posX, posY)
      index += 1
    return this

  resolveSelection: ->
    bottomHand = Hanafuda.instance.bottomHand
    playerCard = bottomHand.selected
    boardCard = @selected
    return if not playerCard or not boardCard
    if playerCard.month is boardCard.month
      playerCard.slidingAnimation = null
      @selected = null
      bottomHand.selected = null
      boardCard.isFocus = boardCard.isSelected = playerCard.isFocus = playerCard.isSelected = false
      bottomHand.validateCard(playerCard)
      bottomHand.validateCard(@cards.splice(@cards.indexOf(boardCard), 1)[0], @addCard.bind(this, @deck.pickup()))