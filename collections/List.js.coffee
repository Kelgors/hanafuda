class Hanafuda.List extends Array
  constructor: ->
    super 0

  clear: ->
    @length = 0

  remove: ->
    index = 0
    len = arguments.length
    removed = new Hanafuda.List
    while index < len
      removed.push(@splice(@indexOf(arguments[index++]), 1)[0])
    return removed

  countWhere: (conditions) ->
    count = k_index = t_index = 0
    t_len = @length
    keys = Object.getOwnPropertyNames(conditions)
    k_len = keys.length
    while t_index < t_len
      k_index = condition_checked = 0
      while k_index < k_len
        condition_checked++ if this[t_index][keys[k_index]] is conditions[keys[k_index]]
        k_index++
      count++ if condition_checked is k_len
      t_index++
    return count

  where: (conditions, limit = Number.MAX_VALUE) ->
    t_index = 0
    t_len = @length
    keys = Object.getOwnPropertyNames(conditions)
    k_index = 0
    k_len = keys.length
    elements = new Hanafuda.List
    while t_index < t_len
      k_index = condition_checked = 0
      while k_index < k_len
        condition_checked++ if this[t_index][keys[k_index]] is conditions[keys[k_index]]
        k_index++
      elements.push(this[t_index]) if condition_checked is k_len
      break if elements.length is limit
      t_index++
    return elements

  each: (iterator) ->
    index = 0
    while index < @length
      iterator(index, this[index], this)
      index++
    return this

  map: (iterator) ->
    index = 0
    elements = new Hanafuda.List
    while index < @length
      r = iterator(index, this[index], this)
      elements.push(r) if r
      index++
    return elements

  last: ->
    return this[@length - 1]

  first: ->
    return this[0]

  size: ->
    return @length

  set: (index, value) ->
    return @splice(index, 1, value)[0]

  slice: ->
    l = new Hanafuda.List()
    l.push.apply(l, Array.prototype.slice.apply(this, arguments))
    return l

  toArray: ->
    return @slice()