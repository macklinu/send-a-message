# Just renders index.jade

City = require('../models').City

exports.index = (req, res) ->
  City.find (err, cities) ->
    res.render 'launch', cities: cities
