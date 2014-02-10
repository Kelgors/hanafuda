#= require ./List
class Hanafuda.Stack extends Hanafuda.List
  constructor: (@maxsize) ->
    super 0

  add: (element) ->
    @unshift(element)
    @splice(@maxsize, @length - @maxsize) if @length > @maxsize
    return