#= require ./views/KoiKoiDeck
#= require ./views/Hand
#= require ./collections/Stack
#= require ./geometry/Point
class Hanafuda.Game
  constructor: (@container) ->
    for key of this
      this[key] = this[key].bind(this) if typeof this[key] == 'function'


    @canvas = document.createElement('canvas')

    @context = @canvas.getContext('2d')

    @canvas.width = Hanafuda.Viewport.x
    @canvas.height = Hanafuda.Viewport.y

    @invalidView = true
    @requestId = null

    handHeight = 150

    @deck = new Hanafuda.KoiKoiDeck
    @deck.setXY(100, handHeight * 2 - Hanafuda.Card.HEIGHT/2)
    @board = new Hanafuda.Board('BOARD', @deck, 0, handHeight, Hanafuda.Viewport.x, handHeight * 2)
    @topHand = new Hanafuda.Hand('TOP', 0, 0, Hanafuda.Viewport.x, handHeight)
    @bottomHand = new Hanafuda.Hand('BOTTOM', 0, handHeight * 3, Hanafuda.Viewport.x, handHeight)
    @bottomHand.isPlayerHand = true


    window.addEventListener('mouseup', @onMouseUp, false)
    @canvas.onmousemove = @onMouseMove
    @canvas.onclick = @onMouseClick

    Hanafuda.runner = new Hanafuda.AnimationRunner

    @DEBUG = {}
    @lastfocus = {}

    @history =
      click: new Hanafuda.Stack(10)
      focus: new Hanafuda.Stack(10)
    @container.appendChild(@canvas)
    Hanafuda.instance = this
    @mouse = new Hanafuda.Point
    @run()

  run: ->
    @requestId = window.requestAnimationFrame(@draw) if @requestId is null
    return

  draw: (totaltime) ->
    delta = totaltime - @lasttime
    @lasttime = totaltime
    Hanafuda.runner.update(delta)
    if Number.isFinite(delta) && @invalidView
      @context.clearRect(0, 0, Hanafuda.Viewport.x, Hanafuda.Viewport.y)

      @topHand.draw(@context)
      @board.draw(@context)
      @bottomHand.draw(@context)
      #@context.fillText(@mouse.toString(), @mouse.x + 10, @mouse.y + 5)
      @invalidView = false
      console.debug('draw')
    @requestId = window.requestAnimationFrame(@draw)
    return

  invalidate: () ->
    @invalidView = true
    return

  getRegion: (posX, posY) ->
    return @board if @board.contains(posX, posY)
    return @topHand if @topHand.contains(posX, posY)
    return @bottomHand if @bottomHand.contains(posX, posY)
    return null

  onMouseMove: (event) ->
    posX = event.layerX
    posY = event.layerY
    event.game = this
    @mouse.set(posX, posY)

    region = @getRegion(posX, posY)
    lastfocus = @focus
    if region
      newfocus = region.getChildAt(posX, posY)
      return if newfocus is lastfocus
      h_event = new Hanafuda.Event(event, this, @mouse)
      h_event.target = lastfocus
      if lastfocus && lastfocus isnt @history.focus.first()
        lastfocus.trigger('unfocus', h_event)
        @history.focus.add(lastfocus)
      h_event.target = @focus = newfocus
      newfocus.trigger('focus', h_event)
    else if @focus
      @focus = null
    return

  onMouseClick: (event) ->
    posX = event.layerX
    posY = event.layerY
    event.game = this

    @click = @getRegion(posX, posY)
    if @click
      @click = @click.getChildAt(posX, posY)
      @click.trigger('click', event)
    return

  onMouseUp: () ->
    if @click
      @history.click.add(@click)
      @click = null
    return

  distribute: () ->
    # if !oddHand or !evenHand
    #   oddHand = @topHand
    #   evenHand = @bottomHand
    # index = 0
    # len = 16
    # while index < len
    #   if index % 2 is 0
    #     oddHand.addCard(@deck.pickup())
    #   else
    #     evenHand.addCard(@deck.pickup())
    #   @board.addCard(@deck.pickup()) if index < 8
    #   index += 1
    # @invalidate()
    @topHand.clear()
    @bottomHand.clear()
    @board.clear()
    do @distributionIterator
    return

  distributionIterator: () ->
    topsize = @topHand.size()
    botsize = @bottomHand.size()
    boasize = @board.size()
    if topsize is botsize && boasize < topsize
      @board.addCard(@deck.pickup())
      boasize++
    else if topsize > botsize
      @bottomHand.addCard(@deck.pickup())
      botsize++
    else
      @topHand.addCard(@deck.pickup())
      topsize++
    return if topsize is botsize && topsize is boasize && topsize is 8
    setTimeout @distributionIterator, 100
    return


Hanafuda.Viewport = new Hanafuda.Point(800, 600)