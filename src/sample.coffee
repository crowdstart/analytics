import session from './session'

sample = (name, pct = 1) ->
  key = 'sample:' + name
  if (sampled = (session.get key))?
    return sampled

  if Math.random() < pct
    session.set key, false
    return false
  else
    session.set key, true
    return true

export default sample
