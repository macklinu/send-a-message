exports.index = (req, res) ->
  res.render 'index', query: req.query
