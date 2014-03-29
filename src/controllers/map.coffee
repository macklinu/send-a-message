exports.index = (req, res) ->
  console.log req.query
  res.render 'index'
