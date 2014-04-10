City = require('../models').City

exports.index = (req, res) ->
  City.find (err, cities) ->
    obj =
      query: req.query
      allCities: cities
    res.header "Cache-Control", "no-cache, no-store, must-revalidate"
    res.header "Pragma", "no-cache"
    res.header "Expires", 0
    res.render 'index', obj
