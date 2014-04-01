City = require('../models').City

exports.index = (req, res) ->
  City.find (err, cities) ->
    obj =
      query: req.query
      allCities: cities
    res.render 'index', obj
