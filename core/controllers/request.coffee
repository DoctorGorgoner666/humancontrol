mongoose = require 'mongoose'
request     = require '../models/request'
debug    = require('debug')('cms:controllers:request')
crud = {}

crud.create = (req, res) ->
  Resource = mongoose.model 'Request'
  rec = new Resource(req.body)
  rec.save (err, resource) ->
    if err then res.json {'ERROR': err}
    else res.json {'SUCCESS': true}

crud.retrieve = (req, res) ->
  Resource = mongoose.model 'Request'
  Resource.find {}, (err, resource) ->
    res.json {'Requests': resource}
