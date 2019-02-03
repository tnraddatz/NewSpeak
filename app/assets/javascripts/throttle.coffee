# This will only call the function if it hasn't been triggered in (delay)ms
@throttle = (fn, delay) ->
  return fn if delay is 0
  timer = false
  return ->
    return if timer
    timer = true
    setTimeout (-> timer = false), delay unless delay is -1
