window.onload = () ->
  time = new Time query
  time.update()

  setInterval (() -> time.update()), 1000
