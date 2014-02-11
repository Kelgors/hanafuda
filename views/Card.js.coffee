#= require ./Region
#= require ../collections/List
class Hanafuda.Card extends Hanafuda.Region
  constructor: (x, y, @type, @month) ->
    @animations = new Hanafuda.List
    @isSelected = @isFocus = false
    super x, y, Hanafuda.Card.WIDTH, Hanafuda.Card.HEIGHT

  setOwner: (owner) ->
    if @owner.isPlayerHand
      @off(null, null, this)
    @owner = owner
    @on 'focus', @onFocusUnfocus, this
    @on 'click', ->
      console.log 'click on ' + @month + ' - ' + @type
      return
    , this
    if owner.isPlayerHand
      console.log('player-hand')
      @on 'focus', @playerEvents.onFocusUnfocus, this
      @on 'unfocus', @playerEvents.onFocusUnfocus, this
    @on 'click', @playerEvents.onClick, this if owner.isPlayerHand or owner instanceof Hanafuda.Board
    return

  onFocusUnfocus: (event) ->
    @isFocus = event.type is 'focus'
    return

  moveTo: (x, y, duration) ->
    if not @isAnimating
      animation = new Hanafuda.MoveAnimation(this, duration || 100, x, y, 'moving')
      Hanafuda.runner.add(animation)
      return animation
    return null

  onSlidingAnimationComplete: ->
    @slidingAnimation = null
    return

  playerEvents:
    onFocusUnfocus: (event) ->
      if @isSelected is false
        posY = @owner.getCardPositionByIndex(@owner.getCardIndex(this)).y
        if event.type is 'unfocus'
          duration = 300
        else if event.type is 'focus'
          posY -= Hanafuda.Card.HEIGHT / 3
          duration = 100
        if @slidingAnimation
          @slidingAnimation.constructor.call(@slidingAnimation, this, duration, @pos.x, posY, 'sliding')
        else
          @slidingAnimation = Hanafuda.runner.add(new Hanafuda.MoveAnimation(this, duration, @pos.x, posY, 'sliding'))
          @slidingAnimation.onComplete(@onSlidingAnimationComplete.bind(this))
      return
    onClick: (event) ->
      console.log(@isFocus, @isSelected)
      return if @isFocus is false
      if @owner.isPlayerHand or event.game.bottomHand.selected
        if @owner.selected is null
          @isSelected = true
          @fill = 'rgba(0,255,0,0.5)'
          @owner.selected = this
          @owner.resolveSelection() if @owner.resolveSelection
          @invalidate()
        else if @owner.selected is this
          @isSelected = false
          @owner.selected = @fill = null
          board = event.game.board
          if board.selected
            board.selected.isSelected = false
            board.selected.fill = null
            board.selected = null
          @invalidate()
      return

Hanafuda.Card.WIDTH = 35
Hanafuda.Card.HEIGHT = 55