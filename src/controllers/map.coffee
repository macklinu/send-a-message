exports.index = (req, res) ->
  city = req.query
  res.render 'index', query: city
