_ = require 'underscore-node'
City = require('../models').City

exports.index = (req, res) ->
  City.find (err, cities) ->
    sortedCities = _(cities).sortBy 'name'
    res.render 'launch', cities: sortedCities
