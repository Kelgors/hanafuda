#= require ./Deck
class Hanafuda.KoiKoiDeck extends Hanafuda.Deck
  constructor: ->
    super
    Card = Hanafuda.Card
    @cards = new Hanafuda.List()
    @cards.push new Card(0, 0, TYPE.COMMON, 1)
    @cards.push new Card(0, 0, TYPE.COMMON, 1)
    @cards.push new Card(0, 0, TYPE.POETRY_RIBBON, 1)
    @cards.push new Card(0, 0, TYPE.SPECIAL, 1)

    @cards.push new Card(0, 0, TYPE.COMMON, 2)
    @cards.push new Card(0, 0, TYPE.COMMON, 2)
    @cards.push new Card(0, 0, TYPE.POETRY_RIBBON, 2)
    @cards.push new Card(0, 0, TYPE.ANIMAL, 2)

    @cards.push new Card(0, 0, TYPE.COMMON, 3)
    @cards.push new Card(0, 0, TYPE.COMMON, 3)
    @cards.push new Card(0, 0, TYPE.POETRY_RIBBON, 3)
    @cards.push new Card(0, 0, TYPE.SPECIAL, 3)

    @cards.push new Card(0, 0, TYPE.COMMON, 4)
    @cards.push new Card(0, 0, TYPE.COMMON, 4)
    @cards.push new Card(0, 0, TYPE.RED_RIBBON, 4)
    @cards.push new Card(0, 0, TYPE.ANIMAL, 4)

    @cards.push new Card(0, 0, TYPE.COMMON, 5)
    @cards.push new Card(0, 0, TYPE.COMMON, 5)
    @cards.push new Card(0, 0, TYPE.RED_RIBBON, 5)
    @cards.push new Card(0, 0, TYPE.ANIMAL, 5)

    @cards.push new Card(0, 0, TYPE.COMMON, 6)
    @cards.push new Card(0, 0, TYPE.COMMON, 6)
    @cards.push new Card(0, 0, TYPE.BLUE_RIBBON, 6)
    @cards.push new Card(0, 0, TYPE.ANIMAL, 6)

    @cards.push new Card(0, 0, TYPE.COMMON, 7)
    @cards.push new Card(0, 0, TYPE.COMMON, 7)
    @cards.push new Card(0, 0, TYPE.RED_RIBBON, 7)
    @cards.push new Card(0, 0, TYPE.ANIMAL, 7)

    @cards.push new Card(0, 0, TYPE.COMMON, 8)
    @cards.push new Card(0, 0, TYPE.COMMON, 8)
    @cards.push new Card(0, 0, TYPE.ANIMAL, 8)
    @cards.push new Card(0, 0, TYPE.SPECIAL, 8)

    @cards.push new Card(0, 0, TYPE.COMMON, 9)
    @cards.push new Card(0, 0, TYPE.COMMON, 9)
    @cards.push new Card(0, 0, TYPE.BLUE_RIBBON, 9)
    @cards.push new Card(0, 0, TYPE.ANIMAL, 9)

    @cards.push new Card(0, 0, TYPE.COMMON, 10)
    @cards.push new Card(0, 0, TYPE.COMMON, 10)
    @cards.push new Card(0, 0, TYPE.BLUE_RIBBON, 10)
    @cards.push new Card(0, 0, TYPE.ANIMAL, 10)

    @cards.push new Card(0, 0, TYPE.COMMON, 11)
    @cards.push new Card(0, 0, TYPE.RED_RIBBON, 11)
    @cards.push new Card(0, 0, TYPE.ANIMAL, 11)
    @cards.push new Card(0, 0, TYPE.SPECIAL, 11)

    @cards.push new Card(0, 0, TYPE.COMMON, 12)
    @cards.push new Card(0, 0, TYPE.COMMON, 12)
    @cards.push new Card(0, 0, TYPE.COMMON, 12)
    @cards.push new Card(0, 0, TYPE.SPECIAL, 12)

  resolveCombo: (card, collection) ->
    count = []
    for c_card, index in collection by 1
      count.push(index) if c_card.month is card.month
    return count
